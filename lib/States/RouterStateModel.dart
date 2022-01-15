import 'package:flutter/cupertino.dart';

enum LocalRoute { LISTING, SETTINGS }

class RouterStateModel extends ChangeNotifier {
  LocalRoute current = LocalRoute.LISTING;

  void setRoute(route) {
    current = route;
    notifyListeners();
  }
}
