import 'package:fluent_ui/fluent_ui.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';
import 'package:stockmanager/models/StockElement.dart';

import 'ElementsList.dart';
import 'ItemDialog.dart';

class ElementEntry extends TableRow {
  final StockElement item;
  final int index;

  final DatabaseInfo database;
  final DatabaseStateModel databaseState;

  final State<ElementsList> listState;

  final BuildContext context;

  final double topAndBottomMargins = 0;

  final Color lightEvenColor = Color.fromARGB(255, 220, 220, 220);
  final Color lightOddColor = Color.fromARGB(255, 240, 240, 240);

  ElementEntry(
    this.index,
    this.item,
    this.database,
    this.databaseState,
    this.context,
    this.listState,
  );

  @override
  Decoration? get decoration {
    return BoxDecoration(
      color: this.index.isEven ? lightEvenColor : lightOddColor,
    );
  }

  @override
  List<Widget>? get children {
    return [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: topAndBottomMargins,
            bottom: topAndBottomMargins,
          ),
          child: Text(this.item.type),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: topAndBottomMargins,
            bottom: topAndBottomMargins,
          ),
          child: Text(this.item.name),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: topAndBottomMargins,
            bottom: topAndBottomMargins,
          ),
          child: Text(this.item.provider),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: topAndBottomMargins,
            bottom: topAndBottomMargins,
          ),
          child: Text(this.item.quantity.toString()),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: topAndBottomMargins,
            bottom: topAndBottomMargins,
          ),
          child: Text(this.item.unitPrice.toString()),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: topAndBottomMargins,
            bottom: topAndBottomMargins,
          ),
          child: Text(this.item.location),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(FluentIcons.edit, color: Colors.blue, size: 20),
              onPressed: () => showDialog(
                context: context,
                builder: (context) =>
                    ItemDialog(mode: "edition", database: this.database, item: this.item, context: context),
              ).then((value) => this.databaseState.updatedDatabase()),
            ),
            IconButton(
              icon: Icon(FluentIcons.clear, color: Colors.red, size: 20),
              onPressed: () => deleteItem(this.item.id),
            ),
          ],
        ),
      ),
    ];
  }

  void deleteItem(int id) {
    this.database.deleteItem(id: id);
    this.databaseState.updatedDatabase();
  }
}
