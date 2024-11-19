import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_flutter_api_rest/src/routes/route.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class BottomNavBarFlex extends StatelessWidget {
  final dynamic buttonColor; // Propiedad para el color del botón

  BottomNavBarFlex({
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.white,
        height: 90.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.userhomeRoute);
                  },
                  icon: const Icon(
                    Icons.storefront,
                    size: 30,
                  ),
                  color: Colors.blue.shade800,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
