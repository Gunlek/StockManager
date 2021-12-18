import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/main.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';

class DatabaseListingEntry extends StatelessWidget {
  final DatabaseInfo database;

  DatabaseListingEntry(this.database);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Text(database.displayName),
            Text(database.host!),
            Text(database.user!),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => HomeState.databaseListState
                      .removeDatabaseFromList(database),
                  splashRadius: 15.0,
                  color: Colors.red,
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
