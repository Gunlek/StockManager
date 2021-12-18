import 'dart:convert';

import 'package:http/http.dart' as http;

import 'StockElement.dart';

class DatabaseInfo {
  String displayName;
  String? host;
  String? user;
  String? password;

  String? _token;
  int? _tokenVerifiedAt;
  int? _tokenValidity;
  bool _connected = false;

  DatabaseInfo(
      {this.displayName = "local",
      this.host = "local",
      this.user,
      this.password});

  Future<void> connect() async {
    if (!this._connected) {
      Uri url = Uri.parse(this.host! + "/auth/login");
      var response = await http
          .post(url, body: {"username": this.user, "password": this.password});

      var jsonResponse = jsonDecode(response.body);
      this._token = jsonResponse['access_token'];
      this._tokenVerifiedAt = int.parse(jsonResponse['verified_at'].toString());

      // Token validity is in seconds, converting it to milliseconds
      this._tokenValidity = int.parse(jsonResponse['valid'].toString()) * 1000;
      _connected = true;
    }
  }

  bool isStillConnected() {
    if (_tokenVerifiedAt == null || _tokenValidity == null) {
      return false;
    } else {
      return (_tokenVerifiedAt! + _tokenValidity!) * 1000 >
          DateTime.now().microsecondsSinceEpoch;
    }
  }

  Future<List<StockElement>> getStock() async {
    this._connected = isStillConnected();
    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/all");
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + this._token!});

      List<StockElement> stockElements = [];
      for (var el in jsonDecode(response.body)) {
        stockElements.add(
          StockElement(
            el['id'], 
            el['type'], 
            el['name'], 
            el['provider'], 
            el['quantity'],
            el['unitPrice'], 
            el['location'], 
            el['createdAt'], 
            el['updatedAt']
          )
        );
      }
      return stockElements;
    } else {
      return [];
    }
  }

  static DatabaseInfo fromJSON(Map<String, String?> json) => DatabaseInfo(
      displayName: json['displayName']!,
      host: json['host'],
      user: json['user'],
      password: json['password']);

  dynamic toJSON() {
    return {
      'displayName': this.displayName,
      'host': this.host,
      'user': this.user,
      'password': this.password
    };
  }
}
