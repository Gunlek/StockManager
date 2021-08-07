class DatabaseInfo {
  String displayName;
  String? host;
  String? user;
  String? password;
  String? port;

  DatabaseInfo(
      {this.displayName = "local",
      this.host,
      this.user,
      this.password,
      this.port});

  static DatabaseInfo fromJSON(json) => DatabaseInfo(
      displayName: json.displayName,
      host: json.host,
      user: json.user,
      password: json.password,
      port: json.port);

  dynamic toJSON() {
    return {
      'displayName': this.displayName,
      'host': this.host,
      'user': this.user,
      'password': this.password,
      'port': this.port
    };
  }
}
