import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';
import 'package:stockmanager/models/StockElement.dart';

import 'ItemDialog.dart';

class ElementEntry extends TableRow {
  final StockElement item;
  final int index;

  final DatabaseInfo database;
  final DatabaseStateModel databaseState;

  final BuildContext context;

  final double topAndBottomMargins = 10;

  final Color lightEvenColor = Color.fromARGB(255, 220, 220, 220);
  final Color lightOddColor = Color.fromARGB(255, 240, 240, 240);

  ElementEntry(
    this.index,
    this.item,
    this.database,
    this.databaseState,
    this.context,
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
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.item.type),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.item.name),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.item.provider),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.item.quantity.toString()),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.item.unitPrice.toString()),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.item.location),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ItemDialog(
                    mode: "edition",
                    database: this.database,
                    item: this.item,
                    context: context),
              ).then((value) => this.databaseState.updatedDatabase()),
              splashRadius: 15.0,
              color: Colors.blue,
              iconSize: 20,
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => deleteItem(this.item.id),
              splashRadius: 15.0,
              color: Colors.red,
              iconSize: 20,
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
