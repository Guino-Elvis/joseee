// // ignore: file_names
// import 'dart:convert';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:front_flutter_api_rest/src/model/urlModel.dart';

// import 'package:http/http.dart' as http;
// import 'package:front_flutter_api_rest/src/providers/provider.dart';

// class ImagenController {
//   Future<http.Response> crearImagen(UrlModel nuevaImagen) async {
//     final urls = Providers.provider();
//     final urlString = urls['imagenListProvider']!;
//     final url = Uri.parse(urlString);
//     final body = jsonEncode(nuevaImagen.toJson());
//     print('Cuerpo de la solicitud: $body');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('imagen creada: ${response.body}');
//     } else {
//       print('Error al crear imagen: ${response.statusCode} - ${response.body}');
//     }
//     return response;
//   }

//   Future<http.Response> editarImagen(UrlModel imagenEditada) async {
//     final urls = Providers.provider();
//     final urlString = urls['imagenListProvider']!;
//     final url = Uri.parse(urlString);

//     final body = jsonEncode(imagenEditada.toJson());

//     final response = await http.put(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 204) {
//       print('imagen editado: ${response.body}');
//     } else {
//       print(
//           'Error al editar imagen: ${response.statusCode} - ${response.body}');
//     }

//     return response;
//   }

//   Future<http.Response> removeImagen(int id, String fotoURL) async {
//     final urls = Providers.provider();
//     final urlString = urls['productoListProvider']!;
//     final url = Uri.parse('$urlString/imagen/$id');

//     var response = await http.delete(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );

//     if (fotoURL.isNotEmpty &&
//         (fotoURL.startsWith('gs://') || fotoURL.startsWith('https://'))) {
//       try {
//         await FirebaseStorage.instance.refFromURL(fotoURL).delete();
//         print("Imagen eliminada de Firebase Storage");
//       } catch (e) {
//         print("Error al eliminar la imagen: $e");
//       }
//     }

//     if (response.statusCode == 200 || response.statusCode == 204) {
//       print("Imagen eliminada ");
//     } else {
//       print(
//           'Error al eliminar sub categoría: ${response.statusCode} - ${response.body}');
//     }
//     return response;
//   }
// }
