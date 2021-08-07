import 'package:flutter/material.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/main.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';

class AddDatabaseDialog extends StatelessWidget {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController hostnameController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 300,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Informations de connexion",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nom d'affichage",
                  ),
                  controller: displayNameController,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Nom d'hôte",
                            ),
                            controller: hostnameController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Port",
                            ),
                            controller: portController,
                          ),
                        ),
                      ],
                    ),
                  ],
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  defaultColumnWidth: FlexColumnWidth(1.0),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Utilisateur",
                  ),
                  controller: usernameController,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Mot de passe",
                  ),
                  controller: passwordController,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      if (_formKey.currentState!.validate())
                        {
                          handleDatabaseCreation(
                            HomeState.databaseListState,
                            context,
                          )
                        }
                    },
                    child: Text("Ajouter la base de données"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleDatabaseCreation(
      DatabaseListStateModel databaseList, BuildContext context) {
    String displayName = displayNameController.value.text;
    String hostname = hostnameController.value.text;
    String port = portController.value.text;
    String username = usernameController.value.text;
    String password = passwordController.value.text;

    databaseList.addDatabaseToList(DatabaseInfo(
      displayName: displayName,
      host: hostname,
      port: port,
      user: username,
      password: password,
    ));

    Navigator.of(context).pop();
  }
}
