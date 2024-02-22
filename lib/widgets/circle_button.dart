import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final VoidCallback onPressed;

  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
