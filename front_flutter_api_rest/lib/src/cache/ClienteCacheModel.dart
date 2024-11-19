import 'package:hive/hive.dart';

part 'ClienteCacheModel.g.dart';

@HiveType(typeId: 2)
class ClienteCacheModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String paterno;

  @HiveField(5)
  final String materno;

  @HiveField(6)
  final String tdocumento;

  @HiveField(7)
  final String direccion;

  @HiveField(8)
  final String postal;

  @HiveField(9)
  final String tdatos;

  ClienteCacheModel({
    this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.paterno,
    required this.materno,
    required this.tdocumento,
    required this.direccion,
    required this.postal,
    required this.tdatos,
  });

  factory ClienteCacheModel.fromJson(Map<String, dynamic> json) {
    return ClienteCacheModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      paterno: json['paterno'],
      materno: json['materno'],
      tdocumento: json['tdocumento'],
      direccion: json['direccion'],
      postal: json['postal'],
      tdatos: json['tdatos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'paterno': paterno,
      'materno': materno,
      'tdocumento': tdocumento,
      'direccion': direccion,
      'postal': postal,
      'tdatos': tdatos,
    };
  }
}
