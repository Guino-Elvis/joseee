import 'package:hive/hive.dart';

part 'EntregaCacheModel.g.dart';

@HiveType(typeId: 3)
class EntregaCacheModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String departamento;

  @HiveField(2)
  final String provincia;

  @HiveField(3)
  final String distrito;

  @HiveField(4)
  final String referencia;

  @HiveField(5)
  final int? authUserId;

  EntregaCacheModel({
    this.id,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    required this.referencia,
    required this.authUserId,
  });

  factory EntregaCacheModel.fromJson(Map<String, dynamic> json) {
    return EntregaCacheModel(
      id: json['id'],
      departamento: json['departamento'],
      provincia: json['provincia'],
      distrito: json['distrito'],
      referencia: json['referencia'],
      authUserId: json['authUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
      'referencia': referencia,
      'authUserId': authUserId,
    };
  }
}
