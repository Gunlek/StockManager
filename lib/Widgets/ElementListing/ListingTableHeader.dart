import 'package:flutter/material.dart';

class ListingTableHeader extends StatelessWidget {
  final EdgeInsets rowPaddings;
  final headerTextStyle = TextStyle(fontWeight: FontWeight.bold);

  ListingTableHeader({required this.rowPaddings});

  @override
  Widget build(BuildContext context) {
    return Table(
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
              child: Text("Emplacement de stockage", style: headerTextStyle),
            ),
            Padding(
              padding: rowPaddings,
              child: Text("Actions", style: headerTextStyle),
            ),
          ],
        ),
      ],
    );
  }
}
