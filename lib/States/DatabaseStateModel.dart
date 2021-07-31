import 'package:flutter/foundation.dart';

class DatabaseStateModel extends ChangeNotifier {
  String database = "local";

  void setDatabase(String _database) {
    database = _database;
    notifyListeners();
  }
}
