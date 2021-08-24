import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:stockmanager/Widgets/DatabaseEditor/DatabaseEditor.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';

class DatabaseStateModel extends ChangeNotifier {
  static DatabaseInfo localDatabase = DatabaseInfo(displayName: "Local");
  DatabaseInfo database = localDatabase;

  void setDatabase(DatabaseInfo _database) {
    database = _database;
    notifyListeners();
  }
}

class DatabaseListStateModel extends ChangeNotifier {
  List<DatabaseInfo> databases = [DatabaseStateModel.localDatabase];
  List<DatabaseInfo> distantDatabases = [];

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
        distantDatabases = databaseList.map((databaseRecord) {
          return DatabaseInfo(
            displayName: databaseRecord.value['displayName'].toString(),
            host: databaseRecord.value['host'].toString(),
            port: databaseRecord.value['port'].toString(),
            user: databaseRecord.value['user'].toString(),
            password: databaseRecord.value['password'].toString(),
          );
        }).toList();
        databases = distantDatabases + [DatabaseStateModel.localDatabase];

        notifyListeners();
      });
    });
  }

  void addDatabaseToList(DatabaseInfo database) {
    databases.insert(0, database);
    distantDatabases.add(database);

    DatabaseEditor.openLocalDatabase(
      (settingsDatabase) async {
        StoreRef store = intMapStoreFactory.store("databases");
        await settingsDatabase.transaction(
          (transaction) async {
            await store.add(transaction, database.toJSON());
          },
        );
      },
    );

    notifyListeners();
  }

  void removeDatabaseFromList(DatabaseInfo database) {
    DatabaseEditor.openLocalDatabase(
      (settingsDatabase) async {
        StoreRef store = intMapStoreFactory.store("databases");
        await settingsDatabase.transaction(
          (transaction) async {
            await store.delete(
              transaction,
              finder: Finder(
                filter: Filter.and(
                  [
                    Filter.equals("displayName", database.displayName),
                    Filter.equals("port", database.port),
                    Filter.equals("host", database.host),
                    Filter.equals("user", database.user),
                    Filter.equals("password", database.password),
                  ],
                ),
              ),
            );
          },
        );

        getDatabaseList();
      },
    );
  }
}
