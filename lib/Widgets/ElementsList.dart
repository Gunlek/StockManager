import 'package:flutter/cupertino.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class ElementsList extends StatefulWidget {
  @override
  State<ElementsList> createState() => ElementsListState();
}

class ElementsListState extends State<ElementsList> {
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
      ),
    );
  }
}
