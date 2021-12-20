import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/ItemDialog.dart';

import '../DatabaseName.dart';

class ListingHeader extends StatefulWidget {
  @override
  _ListingHeaderState createState() => _ListingHeaderState();
}

class _ListingHeaderState extends State<ListingHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseStateModel>(
      builder: (context, databaseState, child) {
        return Container(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  child: DatabaseName(
                    databaseState: databaseState,
                  ),
                ),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (context) => ItemDialog(
                              mode: "creation",
                              database: databaseState.database,
                              context: context,
                            ),
                          ).then((value) => databaseState.updatedDatabase()),
                        },
                        child: Text("Ajouter un item"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
