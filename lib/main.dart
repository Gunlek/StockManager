import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/States/FilterStateModel.dart';
import 'package:stockmanager/States/RouterStateModel.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'Widgets/StateRouter.dart';
import 'Widgets/Wireframe.dart';

void main() {
  runApp(StockManager());
}

class StockManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: "Gestionnaire de stock V1.0",
      theme: ThemeData(
        brightness: Brightness.light
      ),
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
  static FilterStateModel filterStateModel = FilterStateModel();

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
        ChangeNotifierProvider<FilterStateModel>(
          create: (context) => filterStateModel,
        ),
      ],
      child: Wireframe(
        child: StateRouter(),
      ),
    );
  }
}
