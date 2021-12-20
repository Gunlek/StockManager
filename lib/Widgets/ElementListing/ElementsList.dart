import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/ElementEntry.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';
import 'package:stockmanager/models/StockElement.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class ElementsList extends StatefulWidget {
  @override
  State<ElementsList> createState() => ElementsListState();
}

class ElementsListState extends State<ElementsList> {
  final headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  EdgeInsets rowPaddings = EdgeInsets.only(top: 10, bottom: 10);

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
                        padding: rowPaddings,
                        child: Text("Type", style: headerTextStyle),
                      ),
                      Padding(
                        padding: rowPaddings,
                        child: Text("Nom", style: headerTextStyle),
                      ),
                      Padding(
                        padding: rowPaddings,
                        child: Text("Fabricant", style: headerTextStyle),
                      ),
                      Padding(
                        padding: rowPaddings,
                        child: Text("Quantité", style: headerTextStyle),
                      ),
                      Padding(
                        padding: rowPaddings,
                        child: Text("Prix unitaire", style: headerTextStyle),
                      ),
                      Padding(
                        padding: rowPaddings,
                        child: Text("Emplacement de stockage",
                            style: headerTextStyle),
                      ),
                      Padding(
                        padding: rowPaddings,
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
                                  StockElement(
                                    id: element.id,
                                    type: element.type,
                                    name: element.name,
                                    provider: element.provider,
                                    quantity: element.quantity,
                                    unitPrice: element.unitPrice,
                                    location: element.location,
                                  ),
                                  databaseState.database,
                                  databaseState,
                                  context,
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
                          StockElement(
                            id: 0,
                            type: "Electronique",
                            name: "Résistance",
                            provider: "Ebay",
                            quantity: 5,
                            unitPrice: 0.10,
                            location: "Les Angles",
                          ),
                          databaseState.database,
                          databaseState,
                          context,
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
