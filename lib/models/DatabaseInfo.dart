import 'dart:convert';
import 'package:http/http.dart' as http;
import 'StockElement.dart';

// This class handle all database management capabilities
// A DatabaseInfo object contains database's credentials and hostname
// And provides multiples methods to interact with StockManager server
class DatabaseInfo {
  String displayName;
  String? host;
  String? user;
  String? password;

  String? _token;
  int? _tokenVerifiedAt;
  int? _tokenValidity;
  bool _connected = false;

  DatabaseInfo({this.displayName = "local", this.host = "local", this.user, this.password});

  // Connect to distant StockManager server using REST API
  Future<void> connect() async {
    if (!this._connected) {
      Uri url = Uri.parse(this.host! + "/auth/login");
      var response = await http.post(url, body: {"username": this.user, "password": this.password});

      var jsonResponse = jsonDecode(response.body);
      this._token = jsonResponse['access_token'];
      this._tokenVerifiedAt = int.parse(jsonResponse['verified_at'].toString());

      // Token validity is in seconds, converting it to milliseconds
      this._tokenValidity = int.parse(jsonResponse['valid'].toString()) * 1000;
      _connected = true;
    }
  }

  // Compare latest verifiedAt plus token validity duration to current timestamp
  // Ensure token is still valid or not
  bool isStillConnected() {
    if (_tokenVerifiedAt == null || _tokenValidity == null) {
      return false;
    } else {
      return (_tokenVerifiedAt! + _tokenValidity!) * 1000 > DateTime.now().microsecondsSinceEpoch;
    }
  }

  // Get all data from stock using REST API
  // User must be logged in to REST API to do so
  Future<List<StockElement>> getStock({recursive = false}) async {
    this._connected = isStillConnected();
    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/all");
      var response = await http.get(url, headers: {"Authorization": "Bearer " + this._token!});

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

  // Update item's data using REST API
  // User must be logged in to REST API to do so
  Future<void> updateItem({required StockElement item, recursive = false}) async {
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

  // Delete item from REST API
  // User must be logged in to REST API to do so
  Future<void> deleteItem({required int id, recursive = false}) async {
    this._connected = isStillConnected();
    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/delete/" + id.toString());
      await http.delete(url, headers: {"Authorization": "Bearer " + this._token!});
    } else {
      if (!recursive) {
        await this.connect();
        this.deleteItem(id: id);
      }
    }
  }

  // Create item on REST API
  // User must be logged in to REST API to do so
  Future<void> createItem({required Map<String, String> json, recursive = false}) async {
    this._connected = isStillConnected();
    if (this._connected) {
      Uri url = Uri.parse(this.host! + "/item/add/");
      await http.post(
        url,
        headers: {
          "Authorization": "Bearer " + this._token!,
        },
        body: json,
      );
    } else {
      if (!recursive) {
        await this.connect();
        this.createItem(json: json, recursive: true);
      }
    }
  }

  // Create a new DatabaseInfo object from provided json
  static DatabaseInfo fromJSON(Map<String, String?> json) => DatabaseInfo(
        displayName: json['displayName']!,
        host: json['host'],
        user: json['user'],
        password: json['password'],
      );

  // Serialize current DatabaseInfo object to JSON format
  Map<String, String?> toJSON() {
    return {
      'displayName': this.displayName,
      'host': this.host,
      'user': this.user,
      'password': this.password,
    };
  }
}
