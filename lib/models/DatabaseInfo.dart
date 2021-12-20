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

  Future<List<StockElement>> getStock({recursive = false}) async {
    this._connected = isStillConnected();
    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/all");
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + this._token!});

      List<StockElement> stockElements = [];
      for (var el in jsonDecode(response.body)) {
        stockElements.add(StockElement.fromJSON(el));
      }
      return stockElements;
    } else {
      if (!recursive) {
        await this.connect();
        return this.getStock(recursive: true);
      } else {
        return [];
      }
    }
  }

  Future<void> updateItem(
      {required StockElement item, recursive = false}) async {
    this._connected = isStillConnected();

    Map<String, String?> jsonItem = item.toJSON();

    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/update/" + item.id.toString());
      await http.put(
        url,
        headers: {"Authorization": "Bearer " + this._token!},
        body: {
          "type": jsonItem['type'],
          "name": jsonItem['name'],
          "provider": jsonItem['provider'],
          "quantity": jsonItem['quantity'],
          "unitPrice": jsonItem['unitPrice'],
          "location": jsonItem['location'],
        },
      );
    } else {
      if (!recursive) {
        await this.connect();
        this.updateItem(item: item, recursive: true);
      }
    }
  }

  Future<void> deleteItem({required int id, recursive = false}) async {
    this._connected = isStillConnected();
    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/delete/" + id.toString());
      await http
          .delete(url, headers: {"Authorization": "Bearer " + this._token!});
    } else {
      if (!recursive) {
        await this.connect();
        this.deleteItem(id: id);
      }
    }
  }

  static DatabaseInfo fromJSON(Map<String, String?> json) => DatabaseInfo(
      displayName: json['displayName']!,
      host: json['host'],
      user: json['user'],
      password: json['password']);

  Map<String, String?> toJSON() {
    return {
      'displayName': this.displayName,
      'host': this.host,
      'user': this.user,
      'password': this.password
    };
  }
}
