import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/Widgets/DatabaseEditor/AddDatabaseDialog.dart';
import 'package:stockmanager/Widgets/DatabaseEditor/DatabaseEditor.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bases de données sauvegardées"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<DatabaseListStateModel>(builder: (context, databaseList, child) {
                    return OutlinedButton(
                      onPressed: () => Navigator.of(context).restorablePush(_dialogBuilder),
                      child: Text("Ajouter une base de données"),
                    );
                  }),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              DatabaseEditor(),
            ],
          ),
        ),
      ),
    );
  }

  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return mat.DialogRoute<void>(context: context, builder: (context) => AddDatabaseDialog());
  }
}
