import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/Screens/ListingScreen.dart';
import 'package:stockmanager/models/MenuElement.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

import 'Navbar/Navbar.dart';

class Wireframe extends StatefulWidget {
  final Widget child;

  static final List<MenuElement> menuElements = [
    MenuElement(pane: PaneItem(icon: Icon(FluentIcons.home, size: 18), title: Text("Accueil")), slug: "home"),
    MenuElement(pane: PaneItem(icon: Icon(FluentIcons.product_list, size: 18), title: Text("Base de données")), slug: "product_database"),
    MenuElement(pane: PaneItem(icon: Icon(FluentIcons.product_variant, size: 18), title: Text("Groupes")), slug: "product_groups"),
    MenuElement(pane: PaneItem(icon: Icon(FluentIcons.settings, size: 18), title: Text("Paramètres")), slug: "settings"),
  ];


  Wireframe({required this.child});

  @override
  State<Wireframe> createState() => _WireframeState();
}

class _WireframeState extends State<Wireframe> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
        selected: this._currentIndex,
        onChanged: (index) {
          print(Wireframe.menuElements[index].slug);

          setState(() => { this._currentIndex = index });
        },
        items: Wireframe.menuElements.map((el) => el.pane).toList(),
      ),
      content: NavigationBody(
        index: _currentIndex,
        children: [
          const ScaffoldPage(
            content: Text("Home")
          ),
          ListingScreen(),
          const ScaffoldPage(
              content: Text("Groups")
          ),
          const ScaffoldPage(
              content: Text("Settings")
          )
        ]
      )
    );
    /*return Scaffold(
      backgroundColor: CustomColors.lightContrastLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Navbar(),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(
                  CustomTheme.mainPadding,
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
    );*/
  }
}
