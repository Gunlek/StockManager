class DatabaseInfo {
  String displayName;
  String host;

  DatabaseInfo({this.displayName = "local", this.host = "local"});

  static DatabaseInfo fromJSON(Map<String, String?> json) =>
      DatabaseInfo(displayName: json['displayName']!, host: json['host']!);

  dynamic toJSON() {
    return {'displayName': this.displayName, 'host': this.host};
  }
}
