class DatabaseInfo {
  String displayName;
  String? host;
  String? user;
  String? password;

  DatabaseInfo(
    {
      this.displayName = "local",
      this.host,
      this.user,
      this.password
    }
  );

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
