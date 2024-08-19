import 'package:flutter/material.dart';

class MyState with ChangeNotifier {
  bool _isVisible = false;
  bool _userReqVisible = false;

  bool get isVisible => _isVisible;
  bool get userReqVisible => _userReqVisible;

  void toggleUserReq(){
    _userReqVisible = !_userReqVisible;
    notifyListeners();
  }

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
