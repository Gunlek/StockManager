import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bases de données sauvegardées"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<DatabaseListStateModel>(
                        builder: (context, databaseList, child) {
                      return OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .restorablePush(_dialogBuilder),
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
      ],
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
        context: context, builder: (context) => AddDatabaseDialog());
  }
}
