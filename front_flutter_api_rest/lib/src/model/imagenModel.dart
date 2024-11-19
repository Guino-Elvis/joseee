class Imagenes {
  final int? id; // Asegúrate de que esta propiedad esté definida
  final String? url; // Asegúrate de que esta propiedad esté definida
  // Constructor
  Imagenes({required this.id, this.url});

  // Factory constructor para crear una instancia desde un JSON
  factory Imagenes.fromJson(Map<String, dynamic> json) {
    return Imagenes(
      id: json['id'] ?? 'no hay id',
      url: json['url'] ?? 'no hay imagenes',
    );
  }

  // Convertir la instancia a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
