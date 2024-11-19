class UrlModel {
  int? id;
  String? url;
  Map<String, dynamic>? producto;
  // Constructor
  UrlModel({
    this.id,
    this.url,
    this.producto,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory UrlModel.fromJson(Map<String, dynamic> json) {
    return UrlModel(
      id: json['id'] as int?,
      url: json['url'] as String?,
      producto: json['producto'] as Map<String, dynamic>?,
    );
  }
  // Convertir la instancia a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'producto': producto,
    };
  }
}
