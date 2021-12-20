import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/ElementEntry.dart';
import 'package:stockmanager/Widgets/ElementListing/ListingTableHeader.dart';
import 'package:stockmanager/models/StockElement.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

// List elements from currently selected database
// Current database is stored in databaseState used by
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListingTableHeader(rowPaddings: EdgeInsets.only(top: 10, bottom: 10)),
                Consumer<DatabaseStateModel>(
                  builder: (context, databaseState, child) {
                    // TODO: Remove local database capability
                    if (databaseState.database.host != "local") {
                      // If database is distant, not local one
                      return FutureBuilder(
                        future: databaseState.database.getStock(),
                        builder: (context, AsyncSnapshot<List<StockElement>> snapshot) {
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
                      // Dummy data if database is local
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
      ),
    );
  }
}
