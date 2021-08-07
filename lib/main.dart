import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/States/RouterStateModel.dart';

import 'Widgets/StateRouter.dart';
import 'Widgets/Wireframe.dart';

void main() {
  runApp(StockManager());
}

class StockManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static DatabaseStateModel databaseState = DatabaseStateModel();
  static RouterStateModel routerState = RouterStateModel();
  static DatabaseListStateModel databaseListState = DatabaseListStateModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseStateModel>(
          create: (context) => databaseState,
        ),
        ChangeNotifierProvider<RouterStateModel>(
          create: (context) => routerState,
        ),
        ChangeNotifierProvider<DatabaseListStateModel>(
          create: (context) => databaseListState,
        ),
      ],
      child: Wireframe(
        child: StateRouter(),
      ),
    );
  }
}
