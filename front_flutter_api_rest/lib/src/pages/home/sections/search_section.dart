import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/providers/theme.dart';
import 'package:provider/provider.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      color: themeProvider.isDiurno ? themeColors[2] : themeColors[0],
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              child: FadeInLeft(
                duration: Duration(milliseconds: 600),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Transform.rotate(
                        angle: 90 *
                            3.1415926535 /
                            180, // Rota 90 grados hacia la derecha
                        child: Icon(
                          Icons.search,
                          color: themeProvider.isDiurno
                              ? themeColors[2]
                              : themeColors[0],
                        ),
                      ),
                      SizedBox(
                          width:
                              5), // Espacio entre el icono y el campo de texto
                      Container(
                        width: 220,
                        child: Text(
                          'Buscar en Tienda',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Espacio entre el icono y el campo de texto
        ],
      ),
    );
  }
}
