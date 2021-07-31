import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/Widgets/Navbar.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

import 'Screens/ListingScreen.dart';
import 'States/DatabaseStateModel.dart';

void main() {
  runApp(StockManager());
}

class StockManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockManager',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseStateModel(),
      child: Scaffold(
        backgroundColor: CustomColors.lightContrastLight,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Navbar(),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(
                  CustomTheme.mainPadding,
                ),
                child: ListingScreen(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
