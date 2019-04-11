import 'package:flutter/material.dart';
import 'package:flutter_expandable_menu/floating_menu_callback.dart';
import 'package:flutter_expandable_menu/floating_menu_item.dart';

class FlutterExpandableMenu extends StatefulWidget {
  final List<FloatingMenuItem> menuList;
  final AnimatedIconData menuIcon;
  final Color backgroundColor;
  final Color menuBackgroundColor;
  final Duration outerTransitionDuration;
  final Duration menusTransitionDuration;
  final Duration menusTransitionDelay;
  final FloatingMenuCallback callback;
  final Alignment menuAlignment;

  const FlutterExpandableMenu(
      {Key key,
      @required this.menuList,
      this.menuIcon,
      this.backgroundColor,
      this.menuBackgroundColor,
      this.outerTransitionDuration,
      this.menusTransitionDuration,
      this.menusTransitionDelay,
      this.menuAlignment,
      @required this.callback})
      : super(key: key);

  @override
  _FlutterExpandableMenuState createState() => _FlutterExpandableMenuState();
}

class _FlutterExpandableMenuState extends State<FlutterExpandableMenu>
    with TickerProviderStateMixin {
  bool isMenuClicked = false;
  var maxItemCount = 7;

  FloatingMenuItem selectedMenuItem;

  var myHeight = 0.0;
  var myWidth = 0.0;

  AnimationController controller;

  Animation<Offset> offsetTop;
  Animation<Offset> offsetTopRight;
  Animation<Offset> offsetBottomRight;
  Animation<Offset> offsetBottom;
  Animation<Offset> offsetBottomLeft;
  Animation<Offset> offsetTopLeft;
  Animation<double> _animateIcon;
  Animation<double> _animateMenu;

  @override
  void initState() {
    super.initState();
    if (widget.menuList.length == maxItemCount) {
      controller = AnimationController(
          vsync: this,
          duration: widget.menusTransitionDuration != null
              ? widget.menusTransitionDuration
              : Duration(milliseconds: 150));

      _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
      _animateMenu = CurvedAnimation(parent: controller, curve: Curves.easeIn);

      initOffsetValues();
    }
  }

  void initOffsetValues() {
    var curve = Curves.linear;
    var top = FractionalOffset(
            FractionalOffset.topCenter.x, FractionalOffset.topCenter.y)
        .alongSize(Size.fromRadius(0.15));

    offsetTop = Tween<Offset>(begin: Offset.zero, end: Offset(top.dx, top.dy))
        .animate(CurvedAnimation(parent: controller, curve: curve));

    var topRight = FractionalOffset(
            FractionalOffset.topRight.x, FractionalOffset.topRight.y)
        .alongSize(Size.fromRadius(0.14));

    offsetTopRight = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(topRight.dx + 0.05, topRight.dy + 0.15))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.16, 1.0, curve: curve)));

    var bottomRight = FractionalOffset(
            FractionalOffset.bottomRight.x, FractionalOffset.bottomRight.y)
        .alongSize(Size.fromRadius(0.14));

    offsetBottomRight = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(bottomRight.dx + 0.05, bottomRight.dy - 0.15))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.32, 1.0, curve: curve)));

    var bottom = FractionalOffset(
            FractionalOffset.bottomCenter.x, FractionalOffset.bottomCenter.y)
        .alongSize(Size.fromRadius(0.15));

    offsetBottom =
        Tween<Offset>(begin: Offset.zero, end: Offset(bottom.dx, bottom.dy))
            .animate(CurvedAnimation(
                parent: controller, curve: Interval(0.48, 1.0, curve: curve)));

    var bottomLeft = FractionalOffset(
            FractionalOffset.bottomLeft.x, FractionalOffset.bottomLeft.y)
        .alongSize(Size.fromRadius(0.14));

    offsetBottomLeft = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(bottomLeft.dx - 0.05, bottomLeft.dy - 0.15))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.54, 1.0, curve: curve)));

    var topLeft =
        FractionalOffset(FractionalOffset.topLeft.x, FractionalOffset.topLeft.y)
            .alongSize(Size.fromRadius(0.14));

    offsetTopLeft = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(topLeft.dx - 0.05, topLeft.dy + 0.15))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.70, 1.0, curve: curve)));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.menuList.length == maxItemCount) {
      return Stack(
        children: <Widget>[
          _showMenu(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.all(16),
              child: FloatingActionButton(
                onPressed: () {
                  _changeMenuVisibility();
                },
                backgroundColor: widget.menuBackgroundColor != null
                    ? widget.menuBackgroundColor
                    : Theme.of(context).accentColor,
                child: AnimatedIcon(
                    icon: widget.menuIcon != null
                        ? widget.menuIcon
                        : AnimatedIcons.menu_close,
                    progress: _animateIcon),
              ),
            ),
          ),
        ],
      );
    } else {
      throw ("Menu List must have seven(7) items.");
    }
  }

  void _changeMenuVisibility() {
    isMenuClicked = !isMenuClicked;
    if (!isMenuClicked) {
      controller.addStatusListener((state) {
        if (state == AnimationStatus.dismissed) {
          setState(() {});
          if (selectedMenuItem != null) {
            widget.callback.onMenuClick(selectedMenuItem);
          }
        }
      });
      controller.reverse();
    } else {
      setState(() {});
    }
  }

  void _animate() {
    Duration delay = widget.menusTransitionDelay != null
        ? widget.menusTransitionDelay
        : Duration(milliseconds: 400);

    Future.delayed(delay, () {
      controller.forward();
    });
  }

  Widget _showMenu() {
    if (isMenuClicked) {
      myWidth = myHeight = MediaQuery.of(context).size.width;
      _animate();
    } else {
      myWidth = myHeight = 0.0;
    }
    return Align(
      alignment: widget.menuAlignment != null
          ? widget.menuAlignment
          : Alignment.center,
      child: AnimatedContainer(
        duration: widget.outerTransitionDuration != null
            ? widget.outerTransitionDuration
            : Duration(milliseconds: 300),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          color: widget.backgroundColor != null
              ? widget.backgroundColor
              : Colors.black,
        ),
        width: myWidth == 0 ? 0 : MediaQuery.of(context).size.width,
        height: myHeight == 0 ? 0 : MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            width: myWidth,
            height: myHeight,
            margin: EdgeInsets.all(30),
            duration: Duration(milliseconds: 500),
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: widget.backgroundColor != null
                  ? widget.backgroundColor
                  : Colors.black,
            ),
            child: isMenuClicked ? _menuItems() : Container(),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(int index) {
    selectedMenuItem = null;

    var menuItem = widget.menuList[index];
    if (menuItem == null) {
      return Container();
    }
    Animation<Offset> offset;
    switch (index) {
      case 0:
        {
          offset = offsetTop;
        }
        break;
      case 1:
        {
          offset = offsetTopRight;
        }
        break;
      case 2:
        {
          offset = offsetBottomRight;
        }
        break;
      case 3:
        {
          offset = offsetBottom;
        }
        break;
      case 4:
        {
          offset = offsetBottomLeft;
        }
        break;
      case 5:
        {
          offset = offsetTopLeft;
        }
        break;
    }

    if (index != (maxItemCount - 1)) {
      return SlideTransition(
        position: offset,
        child: Center(
          child: FloatingActionButton(
            onPressed: () {
              selectedMenuItem = menuItem;
              _changeMenuVisibility();
            },
            backgroundColor: menuItem.backgroundColor != null
                ? menuItem.backgroundColor
                : Theme.of(context).accentColor,
            child: Icon(menuItem.icon),
          ),
        ),
      );
    } else {
      return Center(
        child: FloatingActionButton(
          onPressed: () {
            selectedMenuItem = menuItem;
            _changeMenuVisibility();
          },
          backgroundColor: menuItem.backgroundColor != null
              ? menuItem.backgroundColor
              : Theme.of(context).accentColor,
          child: Icon(menuItem.icon),
        ),
      );
    }
  }

  Widget _menuItems() {
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            FadeTransition(opacity: _animateMenu, child: _menuItem(0)),
            FadeTransition(opacity: _animateMenu, child: _menuItem(1)),
            FadeTransition(opacity: _animateMenu, child: _menuItem(2)),
            FadeTransition(opacity: _animateMenu, child: _menuItem(3)),
            FadeTransition(opacity: _animateMenu, child: _menuItem(4)),
            FadeTransition(opacity: _animateMenu, child: _menuItem(5)),
            FadeTransition(opacity: _animateMenu, child: _menuItem(6)),
          ],
        ),
      ],
    );
  }
}
