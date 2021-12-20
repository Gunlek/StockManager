import 'package:flutter/material.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';
import 'package:stockmanager/models/StockElement.dart';

class ItemDialog extends StatelessWidget {
  final String mode;
  final StockElement? item;
  final DatabaseInfo database;
  final BuildContext context;

  late final TextEditingController itemTypeController;
  late final TextEditingController itemNameController;
  late final TextEditingController itemProviderController;
  late final TextEditingController itemQuantityController;
  late final TextEditingController itemUnitPriceController;
  late final TextEditingController itemLocationController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ItemDialog({
    required this.mode,
    required this.database,
    this.item,
    required this.context,
  }) {
    this.itemTypeController = TextEditingController(
      text: this.item == null ? "" : this.item!.type,
    );
    this.itemNameController = TextEditingController(
      text: this.item == null ? "" : this.item!.name,
    );
    this.itemProviderController = TextEditingController(
      text: this.item == null ? "" : this.item!.provider,
    );
    this.itemQuantityController = TextEditingController(
      text: this.item == null ? "" : this.item!.quantity.toString(),
    );
    this.itemUnitPriceController = TextEditingController(
      text: this.item == null ? "" : this.item!.unitPrice.toString(),
    );
    this.itemLocationController = TextEditingController(
      text: this.item == null ? "" : this.item!.location,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    this.mode == "edition"
                        ? "Edition d'un item"
                        : "Création d'un item",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Type",
                  ),
                  controller: itemTypeController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nom",
                  ),
                  controller: itemNameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Fournisseur",
                  ),
                  controller: itemProviderController,
                ),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Quantité",
                            ),
                            controller: itemQuantityController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Prix unitaire",
                            ),
                            controller: itemUnitPriceController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Emplacement de stockage",
                  ),
                  controller: itemLocationController,
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
                          this.mode == "edition"
                              ? handleItemEdition()
                              : handleItemCreation()
                        }
                    },
                    child: Text(
                      this.mode == "edition"
                          ? "Mettre à jour le composant"
                          : "Créer le composant",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleItemEdition() {
    if (this.database.host! != "local") {
      item!.type = itemTypeController.value.text;
      item!.name = itemNameController.value.text;
      item!.provider = itemProviderController.value.text;
      item!.quantity = int.parse(itemQuantityController.value.text);
      item!.unitPrice = double.parse(itemUnitPriceController.value.text);
      item!.location = itemLocationController.value.text;

      this.database.updateItem(item: item!);
      Navigator.pop(context, true);
    }
  }

  void handleItemCreation() {
    if (this.database.host! != "local") {
      this.database.createItem(
        json: {
          "type": itemTypeController.value.text,
          "name": itemNameController.value.text,
          "provider": itemProviderController.value.text,
          "quantity": itemQuantityController.value.text,
          "unitPrice": itemUnitPriceController.value.text,
          "location": itemLocationController.value.text,
        },
      );
      Navigator.pop(context, true);
    }
  }
}
