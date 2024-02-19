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
        this.id,
    });

    //factory Producto.fromRawJson(String str) => Producto.fromMap(json.decode(str));
    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    //String toRawJson() => json.encode(toJson());
    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        disponible: json["disponible"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
    };

    Producto copy() => Producto(
      disponible: this.disponible, 
      imagen: this.imagen, // Incluimos la imagen en el copy
      nombre: this.nombre, 
      precio: this.precio,
      id: this.id,  
    );

}
