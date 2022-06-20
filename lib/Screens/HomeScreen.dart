import 'package:fluent_ui/fluent_ui.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: Row(
                children: [
                  Text("StockManager", style: TextStyle(fontSize: 40))
                ]
              )
            ),
            Flexible(
              child: GridView.count(
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 5,
                children: [
                  Button(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(FluentIcons.library, size: 100), Text("Local", style: TextStyle(fontSize: 35))]
                    ),
                    onPressed: () => { print("Jump to <>") },
                    style: ButtonStyle(
                      border: ButtonState.all(BorderSide.none),
                      padding: ButtonState.all(EdgeInsets.zero),
                      backgroundColor: ButtonState.resolveWith(
                        (Set<ButtonStates> states) {
                          if (states.contains(ButtonStates.hovering)) {
                            return Color.fromARGB(255, 230, 230, 230);
                          }
                          else {
                            return Color.fromARGB(255, 240, 240, 240);
                          }
                        }
                      ),
                      shape: ButtonState.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                    )
                  ),
                ]
              )
            ),
          ]
        ),
      ),
    );
  }

}