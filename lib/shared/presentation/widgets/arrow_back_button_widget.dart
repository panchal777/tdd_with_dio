import 'package:flutter/material.dart';

class ArrowBackButtonWidget extends StatelessWidget {
  final Function()? callback;
  final Color? iconColor;

  const ArrowBackButtonWidget({super.key, this.callback, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        onPressed: () {
          callback?.call();
          Navigator.pop(context);
        },
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back,
          color: iconColor ?? Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
