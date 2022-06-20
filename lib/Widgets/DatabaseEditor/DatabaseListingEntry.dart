import 'package:fluent_ui/fluent_ui.dart';
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
                  icon: Icon(FluentIcons.clear, color: Colors.red, size: 20),
                  onPressed: () => HomeState.databaseListState.removeDatabaseFromList(database),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
