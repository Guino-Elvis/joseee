import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/pages/Payment/payment_error.dart';
import 'package:front_flutter_api_rest/src/pages/Payment/payment_success.dart';
import 'package:front_flutter_api_rest/src/pages/categoria_crud/category_list_page.dart';
import 'package:front_flutter_api_rest/src/pages/empresa_crud/category_list_page.dart';
import 'package:front_flutter_api_rest/src/pages/home/AdminHomePage.dart';
import 'package:front_flutter_api_rest/src/pages/home/CarritoPage.dart';
import 'package:front_flutter_api_rest/src/pages/home/Validator.dart';
import 'package:front_flutter_api_rest/src/pages/home/UserHomePage.dart';
import 'package:front_flutter_api_rest/src/pages/home/loginPage.dart';
import 'package:front_flutter_api_rest/src/pages/home/registerPage.dart';
import 'package:front_flutter_api_rest/src/pages/home/welcome.dart';
import 'package:front_flutter_api_rest/src/pages/producto_crud/producto_list_page.dart';
import 'package:front_flutter_api_rest/src/pages/sub_categoria_crud/sub_category_list_page.dart';
import 'package:front_flutter_api_rest/src/pages/usuario_crud/usuario_list_page.dart';

class AppRoutes {
  static const String welcomeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String userhomeRoute = '/user_home';
  static const String adminhomeRoute = '/admin_home';
  static const String categoriaListRoute = '/crud_categoria_list';
  static const String empresaListRoute = '/crud_empresa_list';
  static const String subcategoriaListRoute = '/crud_sub_categoria_list';
  static const String productoListRoute = '/crud_producto_list';
  static const String usuarioListRoute = '/crud_usuario_list';

  static const String paySuccessRoute = '/paymentSuccess';
  static const String payErrorRoute = '/paymentError';
  static const String approvalRoute = '/paymentApproval';
  static const String carritoRoute = '/paymentCarrito';
  static const String pasarelaRoute = '/paymentPasarela';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      welcomeRoute: (context) => WelcomePage(),
      loginRoute: (context) => LoginPage(),
      registerRoute: (context) => RegisterPage(),
      homeRoute: (context) => Validator(),
      userhomeRoute: (context) => UserHomePage(),
      adminhomeRoute: (context) => AdminHomePage(),
      categoriaListRoute: (context) => CategorialistPage(),
      subcategoriaListRoute: (context) => SubCategorialistPage(),
      empresaListRoute: (context) => EmpresalistPage(),
      productoListRoute: (context) => ProductolistPage(),
      usuarioListRoute: (context) => UsuariolistPage(),
      paySuccessRoute: (context) => PaymentSuccessScreen(),
      payErrorRoute: (context) => PaymentErrorScreen(),
      carritoRoute: (context) => CarritoPage(cliente: null),
    };
  }
}
