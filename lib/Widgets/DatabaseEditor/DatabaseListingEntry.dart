import 'package:flutter/cupertino.dart';

class DatabaseListingEntry extends StatelessWidget {
  final String displayName;
  final String host;
  final String port;
  final String user;
  final String password;

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
