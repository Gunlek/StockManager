import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/States/FilterStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/ElementEntry.dart';
import 'package:stockmanager/Widgets/ElementListing/ListingTableHeader.dart';
import 'package:stockmanager/models/StockElement.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

import 'Filter.dart';

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

  Filter filter = Filter.noFilter;

  @override
  void initState() {
    super.initState();
    this.filter = Filter.noFilter;
  }

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
                ListingTableHeader(
                  rowPaddings: EdgeInsets.only(top: 10, bottom: 10),
                  filter: this.filter,
                  onFilterSelection: (type, order) => setState(() {
                    this.filter = Filter(type, order);
                  }),
                ),
                Consumer2<DatabaseStateModel, FilterStateModel>(
                  builder: (context, databaseState, filter, child) {
                    // TODO: Remove local database capability
                    if (databaseState.database.host != "local") {
                      // If database is distant, not local one
                      return FutureBuilder(
                        future: databaseState.database.getStock(),
                        builder: (context, AsyncSnapshot<List<StockElement>> snapshot) {
                          if (snapshot.hasData) {
                            int index = 0;
                            List<StockElement> filteredList = applyFilter(snapshot.data!, filter.filter, filter.searchTerm);
                            List<StockElement> sortedList = sortStock(filteredList, this.filter);
                            return Table(
                              children: sortedList.map(
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
                                    this,
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
                            this,
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

  List<StockElement> sortStock(List<StockElement> elmts, Filter filter) {
    if (filter == Filter.noFilter) return elmts;

    List<String> strKeyList = elmts
        .map((e) {
          switch (filter.type) {
            case FilterType.TYPE:
              return e.type;
            case FilterType.NAME:
              return e.name;
            case FilterType.PROVIDER:
              return e.provider;
            case FilterType.QUANTITY:
              return e.quantity.toString();
            case FilterType.UNIT_PRICE:
              return e.unitPrice.toString();
            case FilterType.LOCATION:
              return e.location;
            default:
              return "";
          }
        })
        .toSet()
        .toList();

    strKeyList.sort();

    if (filter.order == FilterOrder.DESC) strKeyList = strKeyList.reversed.toList();

    List<StockElement> returnList = [];
    for (int k = 0; k < strKeyList.length; k++) {
      String key = strKeyList[k];

      for (int i = 0; i < elmts.length; i++) {
        switch (filter.type) {
          case FilterType.TYPE:
            if (elmts[i].type == key) returnList.add(elmts[i]);
            break;
          case FilterType.NAME:
            if (elmts[i].name == key) returnList.add(elmts[i]);
            break;
          case FilterType.PROVIDER:
            if (elmts[i].provider == key) returnList.add(elmts[i]);
            break;
          case FilterType.QUANTITY:
            if (elmts[i].quantity.toString() == key) returnList.add(elmts[i]);
            break;
          case FilterType.UNIT_PRICE:
            if (elmts[i].unitPrice.toString() == key) returnList.add(elmts[i]);
            break;
          case FilterType.LOCATION:
            if (elmts[i].location == key) returnList.add(elmts[i]);
            break;
          default:
            break;
        }
      }
    }

    return returnList;
  }

  List<StockElement> applyFilter(List<StockElement> elmts, FilterType filter, String searchTerm) {
    if (searchTerm == "") return elmts;

    switch (filter) {
      case FilterType.NONE:
        return elmts;
      case FilterType.TYPE:
        return elmts.where((StockElement elmt) => elmt.type.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      case FilterType.NAME:
        return elmts.where((StockElement elmt) => elmt.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      case FilterType.PROVIDER:
        return elmts.where((StockElement elmt) => elmt.provider.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      case FilterType.QUANTITY:
        return elmts.where((StockElement elmt) => elmt.quantity.toString().toLowerCase().contains(searchTerm.toLowerCase())).toList();
      case FilterType.UNIT_PRICE:
        return elmts.where((StockElement elmt) => elmt.unitPrice.toString().toLowerCase().contains(searchTerm.toLowerCase())).toList();
      case FilterType.LOCATION:
        return elmts.where((StockElement elmt) => elmt.location.toLowerCase().contains(searchTerm.toLowerCase())).toList();
    }
  }
}
