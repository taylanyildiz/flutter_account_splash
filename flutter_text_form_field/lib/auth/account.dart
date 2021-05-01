import 'package:flutter/cupertino.dart';

class Account with ChangeNotifier {
  bool _visibilityLog = false;
  bool get visibilityLog => _visibilityLog;
  set visibilityLog(value) {
    _visibilityLog = !visibilityLog;
    notifyListeners();
  }

  bool _visibilityReg = false;
  bool get visibilityReg => _visibilityReg;
  set visibilityReg(value) {
    _visibilityReg = !_visibilityReg;
    notifyListeners();
  }
}
