import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class BackgroundPage extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool withDrawer;
  final Function()? drawerCallBack;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final PreferredSizeWidget? appBar;

  const BackgroundPage({
    required this.child,
    this.backgroundColor,
    this.withDrawer = false,
    this.drawerCallBack,
    this.scaffoldKey,
    this.appBar,
    super.key,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
  });

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  bool isCallFromDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      key: widget.scaffoldKey,
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          if (!isCallFromDrawer) {
            if (widget.drawerCallBack != null) {
              widget.drawerCallBack!();
            }
          }
          isCallFromDrawer = false;
        }
      },
      drawer:
          widget.withDrawer
              ? Drawer(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: DrawerWidget(),
              )
              : null,
      body: SafeArea(
        bottom: widget.bottomSafeArea,
        top: widget.topSafeArea,
        child: widget.child,
      ),
    );
  }
}
