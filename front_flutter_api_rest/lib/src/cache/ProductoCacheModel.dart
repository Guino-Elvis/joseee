import 'package:hive/hive.dart';

part 'ProductoCacheModel.g.dart';

@HiveType(typeId: 0)
class ProductoCacheModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  String precio;

  @HiveField(3)
  final String foto;

  @HiveField(4) // Cambié este índice de 3 a 4
  int cantidad;

  ProductoCacheModel({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.foto,
    this.cantidad = 1,
  });

  factory ProductoCacheModel.fromJson(Map<String, dynamic> json) {
    return ProductoCacheModel(
      id: json['id'],
      nombre: json['nombre'],
      precio: json['precio'],
      foto: json['foto'],
      cantidad: json['cantidad'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'foto': foto,
      'cantidad': cantidad,
    };
  }
}
