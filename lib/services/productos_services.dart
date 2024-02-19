import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/models.dart';
import 'package:http/http.dart' as http;

class ProductosServices extends ChangeNotifier{
  final String _baseURL = 'fl-productos2023-24-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Producto> producto = [];
  Producto? productoSeleccionado;
  
  bool isLoading = true;
  bool isSaving = false;

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

    return producto;
    //print(this.producto[1].nombre);
  }
  
  Future saveOrCreateProducto( Producto producto ) async {
    isSaving = true;
    notifyListeners();

    //await this.updateProducto(producto);
    if ( producto.id == null ){
      // Crear la entrada
    } else {
      // Update de la entrada
      await this.updateProducto(producto);
      
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProducto( Producto producto) async {
    final url = Uri.https( _baseURL, 'productos/${ producto.id }.json' );
    final resp = await http.put( url, body: producto.toJson() );
    final decodedData = resp.body;

    print( decodedData);

    return producto.id!;
  }
}