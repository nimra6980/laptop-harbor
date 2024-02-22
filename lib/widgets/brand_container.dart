import 'package:flutter/material.dart';

class BrandContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const BrandContainer({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff222E34), // Outer container background color
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(
                    0xff29363D), // Inner container (icon background) color
              ),
              child: Icon(
                icon,
                color: Color(0xffF5F8FB), // Icon color
              ),
            ),
            SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
