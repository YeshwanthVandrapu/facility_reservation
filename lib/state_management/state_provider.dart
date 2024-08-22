import 'package:flutter/material.dart';

class MyState with ChangeNotifier {
  bool _isVisible = false;
  bool _userReqVisible = false;
  Map<String, dynamic> _filters = {};

  bool get isVisible => _isVisible;
  bool get userReqVisible => _userReqVisible;
  Map<String, dynamic> get filters => _filters;

  void toggleUserReq() {
    _userReqVisible = !_userReqVisible;
    notifyListeners();
  }

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void setFilters(Map<String, dynamic> newFilters) {
    _filters = newFilters;
    notifyListeners();
  }
}