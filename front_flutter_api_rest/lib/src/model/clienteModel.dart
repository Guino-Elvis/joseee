class ClienteModel {
  int? id;
  String? email;
  String? phone;
  String? name;
  String? paterno;
  String? materno;
  String? tdocumento;
  String? direccion;
  String? postal;
  String? tdatos;
  String? createdAt;
  String? updatedAt;
  // Constructor
  ClienteModel({
    this.id,
    this.email,
    this.phone,
    this.name,
    this.paterno,
    this.materno,
    this.tdocumento,
    this.direccion,
    this.postal,
    this.tdatos,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      paterno: json['paterno'] as String?,
      materno: json['materno'] as String?,
      tdocumento: json['tdocumento'] as String?,
      direccion: json['direccion'] as String?,
      postal: json['postal'] as String?,
      tdatos: json['tdatos'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  // Convertir la instancia a un JSON
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
