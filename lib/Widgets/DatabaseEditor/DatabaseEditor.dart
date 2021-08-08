import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/Widgets/DatabaseEditor/DatabaseListingEntry.dart';

class DatabaseEditor extends StatefulWidget {
  // Open local database to store settings
  // Use sembast to interact with the local database
  static openLocalDatabase(void Function(Database) callback) {
    if (kIsWeb) {
      // For Flutter Web
      DatabaseFactory dbFactory = databaseFactoryWeb;
      dbFactory.openDatabase("Settings").then((database) => callback(database));
    } else {
      // For both desktop and android/ios
      DatabaseFactory dbFactory = databaseFactoryIo;
      getApplicationDocumentsDirectory().then((directory) => dbFactory
          .openDatabase(join(directory.path, "Settings.db"))
          .then((database) => callback(database)));
    }
  }

  @override
  State<StatefulWidget> createState() => _DatabaseEditorState();
}

class _DatabaseEditorState extends State<DatabaseEditor> {
  Database? db;
  Future<List<RecordSnapshot<int, Map<String, Object?>>>>? databases;
  var store;

  @override
  initState() {
    super.initState();

    DatabaseEditor.openLocalDatabase((database) {
      databases = intMapStoreFactory.store("databases").find(database);
      setState(() => db = database);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontWeight: FontWeight.bold);

    return Consumer<DatabaseListStateModel>(
      builder: (context, databaseListState, child) {
        return Column(
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    Text("Nom", style: style),
                    Text("Hôte", style: style),
                    Text("Actions", style: style),
                  ],
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 150,
              ),
              child: ListView.builder(
                itemCount: databaseListState.distantDatabases.length,
                itemBuilder: (context, index) {
                  return DatabaseListingEntry(
                      databaseListState.distantDatabases[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
