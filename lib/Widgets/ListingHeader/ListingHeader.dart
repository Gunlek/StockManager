import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/States/FilterStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/Filter.dart';
import 'package:stockmanager/Widgets/ElementListing/ItemDialog.dart';

import '../DatabaseName.dart';

class ListingHeader extends StatefulWidget {
  @override
  _ListingHeaderState createState() => _ListingHeaderState();
}

class _ListingHeaderState extends State<ListingHeader> {
  String searchFieldValue = "";
  String searchFieldColumn = "";

  @override
  Widget build(BuildContext context) {
    return Consumer2<DatabaseStateModel, FilterStateModel>(
      builder: (context, databaseState, filter, child) {
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
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Container(
                          width: 150,
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: TextField(
                              onChanged: (String value) => filter.setSearchTerm(value),
                              decoration: InputDecoration(hintText: "Recherche..."),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          height: 50,
                          child: DropdownButton(
                            value: filter.filter,
                            hint: Text("Colonne"),
                            items: [
                              DropdownMenuItem(child: Text("Aucun"), value: FilterType.NONE),
                              DropdownMenuItem(child: Text("Type"), value: FilterType.TYPE),
                              DropdownMenuItem(child: Text("Nom"), value: FilterType.NAME),
                              DropdownMenuItem(child: Text("Fabricant"), value: FilterType.PROVIDER),
                              DropdownMenuItem(child: Text("Quantité"), value: FilterType.QUANTITY),
                              DropdownMenuItem(child: Text("Prix Unitaire"), value: FilterType.UNIT_PRICE),
                              DropdownMenuItem(child: Text("Emplacement de stockage"), value: FilterType.LOCATION),
                            ],
                            onChanged: (FilterType? column) => column != null ? filter.setFilter(column) : filter.setFilter(FilterType.NONE),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ElevatedButton(
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
