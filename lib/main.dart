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
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseStateModel>(
            create: (context) => DatabaseStateModel()),
        ChangeNotifierProvider<RouterStateModel>(
            create: (context) => RouterStateModel()),
      ],
      child: Wireframe(
        child: StateRouter(),
      ),
    );
  }
}
