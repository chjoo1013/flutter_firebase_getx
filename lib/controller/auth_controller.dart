import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/screen/login.dart';
import 'package:firebase_flutter/screen/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user; // User 정보

  FirebaseAuth firebaseAuth = FirebaseAuth.instance; // Firebase 인증 및 기능 관련

  // 컨트롤러 초기화 후 렌더링 이 되고 네트워크 관련 기능들을 초기화를 시켜줄때 사용한다
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(
        firebaseAuth.userChanges()); // stream은 User의 모든 행동을 실시간으로 전달
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }

  void register(String email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        'Error message',
        'User message',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          'Registration is failed',
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        'Error message',
        'User message',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          'Login is failed',
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logOut() {
    firebaseAuth.signOut();
  }
}
