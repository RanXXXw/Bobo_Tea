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
            fontSize: 24, color: const Color.fromARGB(255, 248, 244, 241)),
      ),
      backgroundColor: const Color.fromARGB(255, 202, 199, 222),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
