import 'package:flutter/material.dart';
import 'package:stockmanager/Widgets/ElementListing/Filter.dart';

class HeaderTitleWidget extends StatelessWidget {
  final String text;
  final Function onClick;
  final EdgeInsets rowPaddings;
  final FilterType? filterType;
  final Filter? currentFilter;

  final headerTextStyle = TextStyle(fontWeight: FontWeight.bold);

  HeaderTitleWidget({
    required this.text,
    required this.onClick,
    required this.rowPaddings,
    this.filterType,
    this.currentFilter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.filterType != null) {
          if (this.currentFilter!.type != this.filterType ||
              (this.currentFilter!.type == this.filterType && this.currentFilter!.order == FilterOrder.DESC))
            this.onClick(this.filterType, FilterOrder.ASC);
          else
            this.onClick(this.filterType, FilterOrder.DESC);
        }
      },
      child: Padding(
        padding: rowPaddings,
        child: Row(
          children: [
            Text(this.text, style: headerTextStyle),
            if (this.filterType != null && this.filterType == this.currentFilter!.type)
              Icon(
                this.currentFilter!.order == FilterOrder.ASC ? Icons.arrow_downward : Icons.arrow_upward,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
