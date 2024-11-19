class VoucherDetailModel {
  int? id;
  String? cantidad;
  String? descripcion;
  String? punitario;
  String? importe;
  Map<String, dynamic>? voucher;
  String? createdAt;
  String? updatedAt;
  // Constructor
  VoucherDetailModel({
    this.id,
    this.cantidad,
    this.descripcion,
    this.punitario,
    this.importe,
    this.voucher,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory VoucherDetailModel.fromJson(Map<String, dynamic> json) {
    return VoucherDetailModel(
      id: json['id'] as int?,
      cantidad: json['cantidad'] as String?,
      descripcion: json['descripcion'] as String?,
      punitario: json['punitario'] as String?,
      importe: json['importe'] as String?,
      voucher: json['voucher'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  // Convertir la instancia a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cantidad': cantidad,
      'descripcion': descripcion,
      'punitario': punitario,
      'importe': importe,
      'voucher': voucher,
    };
  }
}
