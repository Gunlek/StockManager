import 'package:fluent_ui/fluent_ui.dart';
import 'package:stockmanager/Widgets/ElementListing/Filter.dart';
import 'package:stockmanager/Widgets/ElementListing/HeaderTitleWidget.dart';

class ListingTableHeader extends StatelessWidget {
  final EdgeInsets rowPaddings;
  final onFilterSelection;
  final Filter? filter;

  ListingTableHeader({required this.rowPaddings, required this.onFilterSelection, this.filter});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            HeaderTitleWidget(
              text: "Type",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
              filterType: FilterType.TYPE,
              currentFilter: this.filter,
            ),
            HeaderTitleWidget(
              text: "Nom",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
              filterType: FilterType.NAME,
              currentFilter: this.filter,
            ),
            HeaderTitleWidget(
              text: "Fabricant",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
              filterType: FilterType.PROVIDER,
              currentFilter: this.filter,
            ),
            HeaderTitleWidget(
              text: "Quantity",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
              filterType: FilterType.QUANTITY,
              currentFilter: this.filter,
            ),
            HeaderTitleWidget(
              text: "Prix unitaire",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
              filterType: FilterType.UNIT_PRICE,
              currentFilter: this.filter,
            ),
            HeaderTitleWidget(
              text: "Emplacement de stockage",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
              filterType: FilterType.LOCATION,
              currentFilter: this.filter,
            ),
            HeaderTitleWidget(
              text: "Actions",
              onClick: this.onFilterSelection,
              rowPaddings: rowPaddings,
            ),
          ],
        ),
      ],
    );
  }
}
