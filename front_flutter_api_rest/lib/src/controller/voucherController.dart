// // ignore: file_names
// import 'dart:convert';
// import 'package:front_flutter_api_rest/src/model/voucherModel.dart';
// import 'package:front_flutter_api_rest/src/providers/provider.dart';
// import 'package:http/http.dart' as http;

// class VoucherController {
//   Future<List<dynamic>> getDataVoucher({String? numero}) async {
//     try {
//       final urls = Providers.provider();
//       String urlString = urls['voucherListProvider']!;

//       // Si el numero es proporcionado, lo agregamos como parámetro de búsqueda
//       if (numero != null && numero.isNotEmpty) {
//         urlString += '/buscar?numero=$numero';
//       }

//       final url = Uri.parse(urlString);
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to load voucher');
//       }
//     } catch (e) {
//       print('Error: $e');
//       return [];
//     }
//   }

//   Future<http.Response> crearVourcher(VoucherModel nuevoVoucher) async {
//     final urls = Providers.provider();
//     final urlString = urls['voucherListProvider']!;
//     final url = Uri.parse(urlString);
//     final body = jsonEncode(nuevoVoucher.toJson());

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Voucher creada: ${response.body}');
//     } else {
//       print(
//           'Error al crear Voucher: ${response.statusCode} - ${response.body}');
//     }
//     return response;
//   }
// }
