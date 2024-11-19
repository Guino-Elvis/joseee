class VoucherModel {
  int? id;
  String? tipo;
  String? numero;
  final DateTime? fecha;
  double? total;
  String? status;
  String? metodo_pago;
  Map<String, dynamic>? cliente;
  String? createdAt;
  String? updatedAt;

  // Constructor
  VoucherModel({
    this.id,
    this.tipo,
    this.numero,
    this.fecha,
    this.total,
    this.status,
    this.metodo_pago,
    this.cliente,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] as int?,
      tipo: json['tipo'] as String?,
      numero: json['numero'] as String?,
      fecha: json['fecha'] != null
          ? DateTime.parse(json['fecha'])
          : null, // Parse to DateTime
      total: json['total'] as double?,
      status: json['status'] as String?,
      metodo_pago: json['metodo_pago'] as String?,
      cliente: json['cliente'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  // Convertir la instancia a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'numero': numero,
      'fecha': fecha?.toIso8601String(),
      'total': total,
      'status': status,
      'metodo_pago': metodo_pago,
      'cliente': cliente,
    };
  }
}
