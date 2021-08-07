import 'package:flutter/cupertino.dart';

class DatabaseListingEntry extends StatelessWidget {
  String displayName;
  String host;
  String port;
  String user;
  String password;

  DatabaseListingEntry(
    this.displayName,
    this.host,
    this.port,
    this.user,
    this.password,
  );

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Text(displayName),
            Text(host + ":" + port),
            Text(user),
          ],
        )
      ],
    );
  }
}
