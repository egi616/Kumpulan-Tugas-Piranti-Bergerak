import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
class AppBarIcon extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const AppBarIcon({
    super.key,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            imagePath,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        )
      ),
    );
  }
}