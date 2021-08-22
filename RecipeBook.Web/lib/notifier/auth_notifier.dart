import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipebook/model/user_detail.dart';
import 'package:recipebook/service/api_service.dart';

class AuthNotifier extends ChangeNotifier {
  UserDetail? _userDetail;
  final ApiService _apiService = ApiService();

  UserDetail? get userDetail => _userDetail;

  void set userDetail(UserDetail? userDetail) {
    _userDetail = userDetail;
    notifyListeners();
  }

  bool get isAuth => _userDetail != null;

  Future getCurrentUser() async {
    try {
      final response = await _apiService.getRequest("/user/current-user");
      if (response.statusCode == 200) {
        final user = UserDetail.fromJson(jsonDecode(response.data as String) as Map<String, dynamic>);
        userDetail = user;
      } else if (response.statusCode == 403) {
        userDetail = null;
      } else {
        //затычка
      }
    } on Exception catch (e) {
      // возможно перенаправление на отдельную страницу
      print(e);
    }
  }

  Future logout() async {
    try {
      final response = await _apiService.postRequestWithoutData("/user/logout");
      if (response.statusCode == 200) {
        userDetail = null;
      } else {
        //
      }
    } on Exception catch (e) {
      // возможно перенаправление на отдельную страницу
      print(e);
    }
  }
}
