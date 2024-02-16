import 'dart:convert';

class Producto {
    bool disponible;
    String? imagen;
    String nombre;
    double precio;
    String? id;

    Producto({
        required this.disponible,
        this.imagen,
        required this.nombre,
        required this.precio,
    });

    factory Producto.fromRawJson(String str) => Producto.fromMap(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        disponible: json["disponible"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
    };
}
