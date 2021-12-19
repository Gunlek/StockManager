import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/ElementEntry.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';
import 'package:stockmanager/models/StockElement.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';
import 'package:http/http.dart' as http;

class ElementsList extends StatefulWidget {
  @override
  State<ElementsList> createState() => ElementsListState();
}

class ElementsListState extends State<ElementsList> {
  final headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.secondaryLight,
            width: CustomTheme.mainBorderWidth,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Table(
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Type", style: headerTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Nom", style: headerTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Fabricant", style: headerTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Quantité", style: headerTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Prix unitaire", style: headerTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Emplacement de stockage",
                            style: headerTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Actions", style: headerTextStyle),
                      ),
                    ],
                  ),
                ],
              ),
              Consumer<DatabaseStateModel>(
                builder: (context, databaseState, child) {
                  if (databaseState.database.host != "local") {
                    return FutureBuilder(
                      future: getList(databaseState.database),
                      builder: (context,
                          AsyncSnapshot<List<StockElement>> snapshot) {
                        if (snapshot.hasData) {
                          int index = 0;
                          return Table(
                            children: snapshot.data!.map(
                              (element) {
                                index++;
                                return ElementEntry(
                                  index - 1,
                                  element.id,
                                  element.type,
                                  element.name,
                                  element.provider,
                                  element.quantity,
                                  element.unitPrice,
                                  element.location,
                                );
                              },
                            ).toList(),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  } else {
                    return Table(
                      children: [
                        ElementEntry(
                          0,
                          0,
                          "Electronique",
                          "Résistance",
                          "Ebay",
                          5,
                          0.10,
                          "Les Angles",
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<StockElement>> getList(DatabaseInfo database) async {
    return database.getStock();
  }
}
