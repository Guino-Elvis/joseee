// ignore: file_names
import 'dart:convert';
import 'package:front_flutter_api_rest/src/model/clienteModel.dart';
import 'package:front_flutter_api_rest/src/providers/provider.dart';
import 'package:http/http.dart' as http;

class ClienteController {
  Future<List<dynamic>> getDataClientes({String? name}) async {
    try {
      final urls = Providers.provider();
      String urlString = urls['clienteListProvider']!;

      // Si el name es proporcionado, lo agregamos como parámetro de búsqueda
      if (name != null && name.isNotEmpty) {
        urlString += '/buscar?name=$name';
      }

      final url = Uri.parse(urlString);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load cliente');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<http.Response> crearCliente(ClienteModel nuevoCliente) async {
    final urls = Providers.provider();
    final urlString = urls['clienteListProvider']!;
    final url = Uri.parse(urlString);
    final body = jsonEncode(nuevoCliente.toJson());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Cliente creado: ${response.body}');
    } else {
      print(
          'Error al crear cliente: ${response.statusCode} - ${response.body}');
    }
    return response;
  }

  Future<http.Response> editarCliente(ClienteModel clienteEditado) async {
    final urls = Providers.provider();
    final urlString = urls['clienteListProvider']!;
    final url = Uri.parse(urlString);

    final body = jsonEncode(clienteEditado.toJson());

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('cliente editado: ${response.body}');
    } else {
      print(
          'Error al editar cliente : ${response.statusCode} - ${response.body}');
    }

    return response;
  }

  Future<http.Response> removeCliente(int id) async {
    final urls = Providers.provider();
    final urlString = urls['clienteListProvider']!;
    final url = Uri.parse('$urlString/$id');

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Cliente eliminado con exito: ${response.body}');
    } else {
      print(
          'Error al eliminar cliente : ${response.statusCode} - ${response.body}');
    }

    return response;
  }
}
