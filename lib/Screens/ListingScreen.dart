import 'package:flutter/cupertino.dart';
import 'package:stockmanager/Widgets/DatabaseName.dart';
import 'package:stockmanager/Widgets/ElementsList.dart';

class ListingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          DatabaseName("DatabaseName"),
          ElementsList(),
        ],
      ),
    );
  }
}
