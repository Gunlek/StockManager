import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:stockmanager/Widgets/DatabaseEditor/DatabaseEditor.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';

class DatabaseStateModel extends ChangeNotifier {
  String database = "Local";

  void setDatabase(String _database) {
    database = _database;
    notifyListeners();
  }
}

class DatabaseListStateModel extends ChangeNotifier {
  List<DatabaseInfo> databases = [DatabaseInfo(displayName: "Local")];

  DatabaseListStateModel() {
    getDatabaseList();
  }

  void setDatabaseList(List<DatabaseInfo> _databases) {
    databases = _databases;
    notifyListeners();
  }

  void getDatabaseList() {
    DatabaseEditor.openLocalDatabase((database) {
      intMapStoreFactory.store("databases").find(database).then((databaseList) {
        databases = databaseList.map((databaseRecord) {
          return DatabaseInfo(
            displayName: databaseRecord.value['displayName'].toString(),
            host: databaseRecord.value['host'].toString(),
            port: databaseRecord.value['port'].toString(),
            user: databaseRecord.value['user'].toString(),
            password: databaseRecord.value['password'].toString(),
          );
        }).toList();
        databases.add(DatabaseInfo(displayName: "Local"));

        notifyListeners();
      });
    });
  }

  void addDatabaseToList(DatabaseInfo database) {
    databases.insert(0, database);

    DatabaseEditor.openLocalDatabase(
      (settingsDatabase) async {
        StoreRef store = intMapStoreFactory.store("databases");
        await settingsDatabase.transaction(
          (transaction) async {
            /* await store.delete(
              transaction,
              finder: Finder(filter: Filter.equals("58", "58")),
            ); */
            await store.add(transaction, database.toJSON());
          },
        );
      },
    );

    notifyListeners();
  }
}
