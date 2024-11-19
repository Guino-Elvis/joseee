import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/cache/ClienteCacheModel.dart';
import 'package:hive/hive.dart';

class ClienteService extends ChangeNotifier {
  Box<ClienteCacheModel>? _clienteCaja;

  ClienteService() {
    // Asegúrate de que la caja ya esté abierta en `main()` antes de llegar aquí.
    if (Hive.isBoxOpen('clientecaja')) {
      _clienteCaja = Hive.box<ClienteCacheModel>('clientecaja');
    } else {
      throw HiveError('La caja "clientecaja" no está abierta.');
    }
  }
  // Getter para obtener la caja
  Box<ClienteCacheModel>? get clienteCaja {
    return _clienteCaja;
  }

  List<ClienteCacheModel> getClientes() {
    return _clienteCaja?.values.toList() ?? [];
  }

  // Método para crear o agregar un cliente
  Future<void> agregarCliente(ClienteCacheModel cliente) async {
    final box = _clienteCaja;
    if (box != null) {
      // Guardamos el cliente con el nuevo id
      await box.add(cliente);
      // Imprimimos los contenidos de la caja
      _printClienteContents();
      notifyListeners();
    } else {
      print('La caja no está abierta, no se pudo agregar el cliente.');
    }
  }

  void _printClienteContents() {
    if (_clienteCaja != null) {
      List<ClienteCacheModel> clienteItems = _clienteCaja!.values.toList();
      if (clienteItems.isEmpty) {
        print('La caja está vacía.');
      } else {
        print('Contenido de la caja:');
        for (var item in clienteItems) {
          print(
              ' Id: ${item.id}, Email: ${item.email}, Phone: ${item.phone}, paterno: ${item.paterno}, materno: ${item.materno}, tdatos: ${item.tdatos}');
        }
      }
    } else {
      print('No se pudo acceder a la caja');
    }
  }

  // Método para obtener un cliente por su ID
  Future<ClienteCacheModel?> obtenerCliente(int id) async {
    final box = _clienteCaja;
    if (box != null) {
      return box.get(id); // Hive ya usa el ID como la clave
    } else {
      print('La caja no está abierta, no se pudo recuperar el cliente.');
      return null;
    }
  }

  // Método para editar un cliente existente
  Future<void> editarCliente(
      int id, ClienteCacheModel clienteActualizado) async {
    final box = _clienteCaja;

    if (box != null) {
      if (box.containsKey(id)) {
        await box.put(id, clienteActualizado);
      }
      print(
          'Cliente actualizado: ${clienteActualizado.name},${clienteActualizado.id}');
    } else {
      print('La caja no está abierta, no se pudo agregar el cliente.');
    }
  }

  // Método para eliminar un cliente por su ID
  Future<void> eliminarCliente(int id) async {
    final box = _clienteCaja;
    if (box != null) {
      // Verifica si el id existe en la caja antes de intentar eliminarlo
      if (box.containsKey(id)) {
        await box.delete(id); // Eliminar por la clave del id
        print('Cliente eliminado con id: $id');
      } else {
        print('El cliente con id $id no existe en la caja.');
      }
    } else {
      print('La caja no está abierta, no se pudo eliminar el cliente.');
    }
  }

  Future<void> limpiarCliente() async {
    final box = _clienteCaja; // Asumiendo que tienes una caja para el carrito
    if (box != null) {
      await box.clear(); // Elimina todos los elementos de la caja
      print('Cliente limpiado');
    } else {
      print('No se pudo acceder al carrito para limpiarlo');
    }
  }
}
