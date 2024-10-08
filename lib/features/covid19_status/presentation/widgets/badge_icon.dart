import 'package:flutter/material.dart';
class BadgeIcon extends StatelessWidget {
  const BadgeIcon(
      {this.icon,
        this.badgeCount = 3,
        this.showIfZero = false,
        this.badgeColor = Colors.red,
        TextStyle badgeTextStyle})
      : badgeTextStyle = badgeTextStyle ??
      const TextStyle(
        color: Colors.white,
        fontSize: 8,
      );
  final Widget icon;
  final int badgeCount;
  final bool showIfZero;
  final Color badgeColor;
  final TextStyle badgeTextStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      icon,
      if (badgeCount > 0 || showIfZero) badge(badgeCount),
    ]);
  }

  Widget badge(int count) => Positioned(
    right: 0,
    top: 0,
    child: Container(
      width: 25,
      height: 25,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8.5),
      ),
      constraints: const BoxConstraints(
        minWidth: 15,
        minHeight: 15,
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}