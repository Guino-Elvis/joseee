class EntregaModel {
  int? id;
  String? departamento;
  String? provincia;
  String? distrito;
  String? referencia;
  String? authuserid;

  // Constructor
  EntregaModel({
    this.id,
    this.departamento,
    this.provincia,
    this.distrito,
    this.referencia,
    this.authuserid,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory EntregaModel.fromJson(Map<String, dynamic> json) {
    return EntregaModel(
      id: json['id'] as int?,
      departamento: json['departamento'] as String?,
      provincia: json['provincia'] as String?,
      distrito: json['distrito'] as String?,
      referencia: json['referencia'] as String?,
      authuserid: json['authuserid'] as String?,
    );
  }

  // Convertir la instancia a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
      'referencia': referencia,
      'authuserid': authuserid,
    };
  }
}
