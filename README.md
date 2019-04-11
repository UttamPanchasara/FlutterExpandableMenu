# flutter_expandable_menu
![Download](https://img.shields.io/badge/flutter_floating_menu-0.0.1-blue.svg)

A new Flutter package which helps developers in creating Expandable Menu.

## Getting Started

| <img src="https://github.com/UttamPanchasara/Flutter-Expandable-Menu/blob/master/gif/menu_1.gif" height="400" alt="Screenshot"/> | <img src="https://github.com/UttamPanchasara/Flutter-Expandable-Menu/blob/master/gif/menu_2.gif" height="400" alt="Screenshot"/> |

## Usage

[Example](https://github.com/UttamPanchasara/FlutterExamples)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/UttamPanchasara/FlutterExpandableMenu/blob/master/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    flutter_floating_menu: ^0.0.1
```

## Quick Start:
In order to use Expandable Menu Widget in your Application you will have to **Put this widget inside the Stack Widget** as below.

```dart

    Stack(
            children: <Widget>[
              Center(
                child: Text(
                  centerText,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              CircularMenu(
                menuList: floatMenuList,
                callback: this,
                backgroundColor: Colors.transparent,
                menuBackgroundColor: Colors.black,
                menuIcon: AnimatedIcons.menu_close,
                menuAlignment: Alignment.center,
                outerTransitionDuration: Duration(milliseconds: 300),
                menusTransitionDuration: Duration(milliseconds: 500),
                menusTransitionDelay: Duration(milliseconds: 200),
              ),
            ],
          )

```

## Example - How to use:

```dart

class _RoundMenuState extends State<RoundMenu>
    with TickerProviderStateMixin
    implements FloatingMenuCallback {
  String centerText = "Home";

  final List<FloatingMenuItem> floatMenuList = [
    FloatingMenuItem(
        id: 1, icon: Icons.favorite, backgroundColor: Colors.deepOrangeAccent),
    FloatingMenuItem(id: 2, icon: Icons.map, backgroundColor: Colors.brown),
    FloatingMenuItem(id: 3, icon: Icons.email, backgroundColor: Colors.indigo),
    FloatingMenuItem(id: 4, icon: Icons.event, backgroundColor: Colors.pink),
    FloatingMenuItem(id: 5, icon: Icons.print, backgroundColor: Colors.green),
    FloatingMenuItem(
        id: 6, icon: Icons.home, backgroundColor: Colors.deepPurple),
    FloatingMenuItem(
        id: 7, icon: Icons.location_on, backgroundColor: Colors.blueAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round Menu'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              centerText,
              style: TextStyle(color: Colors.black),
            ),
          ),
          CircularMenu(
            menuList: floatMenuList,
            callback: this,
            backgroundColor: Colors.transparent,
            menuBackgroundColor: Colors.black,
            menuIcon: AnimatedIcons.menu_close,
            menuAlignment: Alignment.center,
            outerTransitionDuration: Duration(milliseconds: 300),
            menusTransitionDuration: Duration(milliseconds: 500),
            menusTransitionDelay: Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  @override
  void onMenuClick(FloatingMenuItem floatingMenuItem) {
    if (floatingMenuItem != null) {
      print("onMenuClicked : " + floatingMenuItem.id.toString());
      switch (floatingMenuItem.id) {
        case 1:
          {
            centerText = "Favorite";
          }
          break;
        case 2:
          {
            centerText = "Map";
          }
          break;
        case 3:
          {
            centerText = "Email";
          }
          break;
        case 4:
          {
            centerText = "Event";
          }
          break;
        case 5:
          {
            centerText = "Print";
          }
          break;
        case 6:
          {
            centerText = "Home";
          }
          break;
        case 7:
          {
            centerText = "Location";
          }
          break;
      }

      setState(() {});
    }
  }
}

```

## Questions?

 **Ping-Me on :**  [![Twitter](https://img.shields.io/badge/Twitter-%40UTM__Panchasara-blue.svg)](https://twitter.com/UTM_Panchasara)
[![Facebook](https://img.shields.io/badge/Facebook-Uttam%20Panchasara-blue.svg)](https://www.facebook.com/UttamPanchasara94)


 <a href="https://stackoverflow.com/users/5719935/uttam-panchasara">
<img src="https://stackoverflow.com/users/flair/5719935.png" width="208" height="58" alt="profile for Uttam Panchasara at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for Uttam Panchasara at Stack Overflow, Q&amp;A for professional and enthusiast programmers">
</a>


## Donate
> If you found this package helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
- Google Pay **(panchasarauttam@okaxis)**


## License

```
   Copyright 2019 Uttam Panchasara

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

