class EmpresaModel {
  int? id;
  String? ra_social;
  String? marca;
  String? numero;
  String? foto;
  // Constructor
  EmpresaModel({
    this.id,
    this.ra_social,
    this.marca,
    this.numero,
    this.foto,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory EmpresaModel.fromJson(Map<String, dynamic> json) {
    return EmpresaModel(
      id: json['id'] as int?,
      ra_social: json['ra_social'] as String?,
      marca: json['marca'] as String?,
      numero: json['numero'] as String?,
      foto: json['foto'] as String?,
    );
  }

  // Convertir la instancia a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ra_social': ra_social,
      'marca': marca,
      'numero': numero,
      'foto': foto,
    };
  }
}
