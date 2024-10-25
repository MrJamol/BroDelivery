import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;

  const ProfileMenuItem({required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      onTap: () {
      },
    );
  }
}
