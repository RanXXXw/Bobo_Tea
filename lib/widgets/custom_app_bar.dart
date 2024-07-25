import 'package:bobo_tea/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final double height;

  const ReusableAppBar(
      {Key? key, required this.titleText, this.height = kToolbarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        titleText,
        style: GoogleFonts.courgette(
            fontSize: AppDimens.textL, color: const Color.fromARGB(255, 248, 244, 241)),
      ),
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
