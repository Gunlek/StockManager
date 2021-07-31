import 'package:flutter/material.dart';
import 'package:stockmanager/Widgets/Navbar.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

import 'Widgets/ElementsList.dart';

void main() {
  runApp(StockManager());
}

class StockManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockManager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightContrastLight,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Navbar(),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(
                CustomTheme.mainPadding,
              ),
              child: Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Text("DatabaseName"),
                    ),
                    ElementsList(),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
