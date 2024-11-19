import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:front_flutter_api_rest/src/components/app_bar_show.dart';
import 'package:front_flutter_api_rest/src/model/empresaModel.dart';
import 'package:front_flutter_api_rest/src/providers/theme.dart';
import 'package:front_flutter_api_rest/src/routes/route.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmpresaShowPage extends StatefulWidget {
  final EmpresaModel item;

  EmpresaShowPage({required this.item});

  @override
  _EmpresaShowPageState createState() => _EmpresaShowPageState();
}

class _EmpresaShowPageState extends State<EmpresaShowPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Scaffold(
      backgroundColor: themeProvider.isDiurno ? themeColors[2] : themeColors[0],
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppBarShow(
              onBackTap: () {
                Navigator.pushNamed(context, AppRoutes.empresaListRoute);
              },
              title: widget.item.ra_social?.toString() ?? 'no hay ra_social',
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: widget.item.foto.toString(),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/nofoto.jpg'),
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: themeProvider.isDiurno
                          ? themeColors[2]
                          : themeColors[0],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.white.withOpacity(0.4), // Sombra más suave
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    child: Center(
                        child: Text(
                      widget.item.ra_social?.toString().toUpperCase() ??
                          'no hay ra_social',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
            Container(
              child: ClipPath(
                clipper: WaveClipperOne(reverse: true),
                child: Container(
                  height: 520,
                  width: MediaQuery.of(context)
                      .size
                      .width, // Establecer la altura según la pantalla
                  decoration: BoxDecoration(
                    color: themeProvider.isDiurno
                        ? themeColors[1]
                        : themeColors[7],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 90),
                        ClipPath(
                          clipper: WaveClipperOne(reverse: true),
                          child: Container(
                            width: 380,
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Estado de la empresa:',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      widget.item.numero.toString() ??
                                          'no hay numero',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Nombre de la empresa:',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      widget.item.ra_social.toString() ??
                                          'no hay marca',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Tag de la empresa:',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      widget.item.marca.toString() ??
                                          'no hay marca',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: themeProvider.isDiurno
                                  ? themeColors[2]
                                  : themeColors[0],
                              borderRadius: BorderRadius.circular(150),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white
                                      .withOpacity(0.1), // Sombra más suave
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(-2, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
