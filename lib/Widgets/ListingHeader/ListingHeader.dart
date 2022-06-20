import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/States/FilterStateModel.dart';
import 'package:stockmanager/Widgets/ElementListing/Filter.dart';
import 'package:stockmanager/Widgets/ElementListing/ItemDialog.dart';
import 'package:stockmanager/i18n/FR/Filters.dart';

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
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Container(
                    width: double.infinity,
                    child: DatabaseName(
                      databaseState: databaseState,
                    ),
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
                            child: TextBox(
                              onChanged: (String value) => filter.setSearchTerm(value),
                              placeholder: "Recherche...",
                              // decoration: InputDecoration(hintText: "Recherche..."),
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
                          width: 150,
                          child: DropDownButton(
                            title: Text(I18NFilters.mapFilters[filter.filter]!),
                            items: [
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.NONE]!),        onPressed: () => filter.setFilter(FilterType.NONE)),
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.TYPE]!),        onPressed: () => filter.setFilter(FilterType.TYPE)),
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.NAME]!),        onPressed: () => filter.setFilter(FilterType.NAME)),
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.PROVIDER]!),    onPressed: () => filter.setFilter(FilterType.PROVIDER)),
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.QUANTITY]!),    onPressed: () => filter.setFilter(FilterType.QUANTITY)),
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.UNIT_PRICE]!),  onPressed: () => filter.setFilter(FilterType.UNIT_PRICE)),
                              MenuFlyoutItem(text: Text(I18NFilters.mapFilters[FilterType.LOCATION]!),    onPressed: () => filter.setFilter(FilterType.LOCATION)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 25),
                        child: Button(
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
