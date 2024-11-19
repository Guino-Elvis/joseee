// // ignore: file_names
// import 'dart:convert';
// import 'package:front_flutter_api_rest/src/model/entregaModel.dart';
// import 'package:front_flutter_api_rest/src/providers/provider.dart';
// import 'package:http/http.dart' as http;

// class EntregaController {
//   Future<List<dynamic>> getDataEntregas({String? name}) async {
//     try {
//       final urls = Providers.provider();
//       String urlString = urls['entregaListProvider']!;

//       // Si el name es proporcionado, lo agregamos como parámetro de búsqueda
//       if (name != null && name.isNotEmpty) {
//         urlString += '/buscar?name=$name';
//       }

//       final url = Uri.parse(urlString);
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to load entrega');
//       }
//     } catch (e) {
//       print('Error: $e');
//       return [];
//     }
//   }

//   Future<http.Response> crearEntrega(EntregaModel nuevoEntrega) async {
//     final urls = Providers.provider();
//     final urlString = urls['entregaListProvider']!;
//     final url = Uri.parse(urlString);
//     final body = jsonEncode(nuevoEntrega.toJson());

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Entrega creado: ${response.body}');
//     } else {
//       print(
//           'Error al crear entrega: ${response.statusCode} - ${response.body}');
//     }
//     return response;
//   }

//   Future<http.Response> editarEntrega(EntregaModel entregaEditado) async {
//     final urls = Providers.provider();
//     final urlString = urls['entregaListProvider']!;
//     final url = Uri.parse(urlString);

//     final body = jsonEncode(entregaEditado.toJson());

//     final response = await http.put(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 204) {
//       print('entrega editado: ${response.body}');
//     } else {
//       print(
//           'Error al editar entrega : ${response.statusCode} - ${response.body}');
//     }

//     return response;
//   }

//   Future<http.Response> removeEntrega(int id) async {
//     final urls = Providers.provider();
//     final urlString = urls['entregaListProvider']!;
//     final url = Uri.parse('$urlString/$id');

//     var response = await http.delete(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );

//     print("Status Code: ${response.statusCode}");
//     print("Response Body: ${response.body}");

//     if (response.statusCode == 200 || response.statusCode == 204) {
//       print('Entrega eliminado con exito: ${response.body}');
//     } else {
//       print(
//           'Error al eliminar entrega : ${response.statusCode} - ${response.body}');
//     }

//     return response;
//   }
// }
