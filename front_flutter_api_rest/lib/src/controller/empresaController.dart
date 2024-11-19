// ignore: file_names
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:front_flutter_api_rest/src/model/empresaModel.dart';
import 'package:front_flutter_api_rest/src/providers/provider.dart';
import 'package:http/http.dart' as http;

class EmpresaController {
  Future<List<dynamic>> getDataEmpresas({String? nombre}) async {
    try {
      final urls = Providers.provider();
      String urlString = urls['empresaListProvider']!;

      // Si el nombre es proporcionado, lo agregamos como parámetro de búsqueda
      if (nombre != null && nombre.isNotEmpty) {
        urlString += '/buscar?nombre=$nombre';
      }

      final url = Uri.parse(urlString);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<http.Response> crearEmpresa(EmpresaModel nuevaEmpresa) async {
    final urls = Providers.provider();
    final urlString = urls['empresaListProvider']!;
    final url = Uri.parse(urlString);
    final body = jsonEncode(nuevaEmpresa.toJson());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Categoría creada: ${response.body}');
    } else {
      print(
          'Error al crear categoría: ${response.statusCode} - ${response.body}');
    }
    return response;
  }

  Future<http.Response> editarEmpresa(EmpresaModel empresaEditada) async {
    final urls = Providers.provider();
    final urlString = urls['empresaListProvider']!;
    final url = Uri.parse(urlString);

    final body = jsonEncode(empresaEditada.toJson());

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Categoría editada: ${response.body}');
    } else {
      print(
          'Error al editar categoría: ${response.statusCode} - ${response.body}');
    }

    return response;
  }

  Future<http.Response> removeEmpresa(int id, String fotoURL) async {
    final urls = Providers.provider();
    final urlString = urls['empresaListProvider']!;
    final url = Uri.parse('$urlString/$id');

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (fotoURL.isNotEmpty &&
        (fotoURL.startsWith('gs://') || fotoURL.startsWith('https://'))) {
      try {
        await FirebaseStorage.instance.refFromURL(fotoURL).delete();
        print("Imagen eliminada de Firebase Storage");
      } catch (e) {
        print("Error al eliminar la imagen: $e");
      }
    }

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 204) {
    } else {
      print(
          'Error al eliminar categoría: ${response.statusCode} - ${response.body}');
    }

    return response;
  }
}
