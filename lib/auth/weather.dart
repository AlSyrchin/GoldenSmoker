import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldensmoker/auth/api_client.dart';

class AuthModel extends GetxController{
  final _apiClient = ApiClient();

  final loginControl = TextEditingController().obs;
  final passwordControl = TextEditingController().obs;

  RxString _errorMassege = ''.obs;
  String get errorMassege => _errorMassege.value;  

  RxBool _isAuthProgress = false.obs;
  bool get canStartAuth => !_isAuthProgress.value;

  Future<void> auth (BuildContext context) async{
    final login = loginControl.value.text;
    final password = passwordControl.value.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMassege.value = 'Заполни логин и пароль';
      return;
    }
    _errorMassege.value = '';
    _isAuthProgress.value = true;
    String? session;
    try{
      session = await _apiClient.auth(username: login, password: password);
    }
    catch(e){
      _errorMassege.value = 'None';
    }
    _isAuthProgress.value = false;
    // переход
  }
}