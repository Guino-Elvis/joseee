import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter_api_rest/src/components/app_bar.dart';
import 'package:front_flutter_api_rest/src/components/drawers.dart';
import 'package:front_flutter_api_rest/src/controller/auth/ShareApiTokenController.dart';
import 'package:front_flutter_api_rest/src/pages/home/loginPage.dart';
import 'package:front_flutter_api_rest/src/providers/theme.dart';

import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true; // Para manejar el estado de carga
  bool _isAdmin = false; // Para verificar si el usuario es administrador

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    _checkAdminRole();
  }

  Future<void> _checkAdminRole() async {
    try {
      final loginDetails = await ShareApiTokenController.loginDetails();
      final role = loginDetails?.user?.role ?? "";

      if (role != 'admin') {
        // Mostrar el mensaje antes de redirigir
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'No tienes los permisos necesarios para acceder a esta sección.')),
        );
        // Redirigir después de un breve retraso para dar tiempo al SnackBar
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        });
      } else {
        setState(() {
          _isAdmin = true; // El usuario es administrador
          _isLoading = false; // Terminar el estado de carga
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Terminar el estado de carga
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al verificar el rol del usuario.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    if (_isLoading) {
      return Scaffold(
        appBar: AppBarComponent(
            appBarColor:
                themeProvider.isDiurno ? themeColors[2] : themeColors[0]),
        drawer: NavigationDrawerWidget(),
        backgroundColor:
            themeProvider.isDiurno ? Colors.black12 : themeColors[7],
        body: Center(child: CircularProgressIndicator()), // Indicador de carga
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(
        appBarColor: themeProvider.isDiurno ? themeColors[2] : themeColors[0],
      ),
      drawer: NavigationDrawerWidget(),
      backgroundColor: themeProvider.isDiurno ? Colors.black12 : themeColors[7],
      body: _isAdmin
          ? Column(
              children: [
                Container(
                  child: Text('¡Hola, soy ADMIN!'),
                ),
              ],
            )
          : Container(),
    );
  }
}
