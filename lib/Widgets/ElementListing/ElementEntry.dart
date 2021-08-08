import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/theme/CustomColors.dart';

class ElementEntry extends TableRow {
  final int index;
  final String type;
  final String name;
  final String provider;
  final int quantity;
  final double unitPrice;
  final String location;

  final double topAndBottomMargins = 10;

  final Color lightEvenColor = Color.fromARGB(255, 220, 220, 220);
  final Color lightOddColor = Color.fromARGB(255, 240, 240, 240);

  ElementEntry(
    this.index,
    this.type,
    this.name,
    this.provider,
    this.quantity,
    this.unitPrice,
    this.location,
  );

  @override
  Decoration? get decoration {
    return BoxDecoration(
      color: this.index.isEven ? lightEvenColor : lightOddColor,
    );
  }

  @override
  List<Widget>? get children {
    return [
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.type),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.name),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.provider),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.quantity.toString()),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.unitPrice.toString()),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: topAndBottomMargins,
          bottom: topAndBottomMargins,
        ),
        child: Text(this.location),
      ),
    ];
  }
}
