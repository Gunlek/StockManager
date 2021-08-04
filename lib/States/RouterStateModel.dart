import 'package:flutter/cupertino.dart';

class RouterStateModel extends ChangeNotifier {
  String current = "listing";

  void setRoute(route) {
    current = route;
    notifyListeners();
  }
}
