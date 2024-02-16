import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/models.dart';
import 'package:http/http.dart' as http;

class ProductosServices extends ChangeNotifier{
  final String _baseURL = 'fl-productos2023-24-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Producto> producto = [];
  Producto? productoSeleccionado;
  
  bool isLoading = true;

  ProductosServices(){
    this.loadProductos();
  }

  Future<List<Producto>> loadProductos() async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https( _baseURL, 'productos.json' );
    final resp = await http.get( url );

    final Map<String, dynamic> productosMap = json.decode(resp.body);

    productosMap.forEach((key, value) {
      final tempProduct = Producto.fromMap ( value );
      tempProduct.id = key;
      this.producto.add (tempProduct);

    });
    
    this.isLoading = false;
    notifyListeners();

    return this.producto;
    //print(this.producto[1].nombre);
  }
}