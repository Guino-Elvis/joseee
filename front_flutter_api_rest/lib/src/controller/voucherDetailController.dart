// // ignore: file_names
// import 'dart:convert';

// import 'package:front_flutter_api_rest/src/model/voucherDetailModel.dart';
// import 'package:front_flutter_api_rest/src/providers/provider.dart';
// import 'package:http/http.dart' as http;

// class VoucherDetailController {
//   Future<List<dynamic>> getDataVoucherDetails({String? name}) async {
//     try {
//       final urls = Providers.provider();
//       String urlString = urls['voucherDetailListProvider']!;

//       // Si el name es proporcionado, lo agregamos como parámetro de búsqueda
//       if (name != null && name.isNotEmpty) {
//         urlString += '/buscar?name=$name';
//       }

//       final url = Uri.parse(urlString);
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to load voucherDetail');
//       }
//     } catch (e) {
//       print('Error: $e');
//       return [];
//     }
//   }

//   Future<http.Response> crearVoucherDetail(
//       VoucherDetailModel nuevovoucherDetail) async {
//     final urls = Providers.provider();
//     final urlString = urls['voucherDetailListProvider']!;
//     final url = Uri.parse(urlString);
//     final body = jsonEncode(nuevovoucherDetail.toJson());

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('voucherDetail creado: ${response.body}');
//     } else {
//       print(
//           'Error al crear voucherDetail: ${response.statusCode} - ${response.body}');
//     }
//     return response;
//   }
// }
