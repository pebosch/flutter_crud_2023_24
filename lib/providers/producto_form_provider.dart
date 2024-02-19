import 'package:flutter/material.dart';
import 'package:flutter_crud/models/models.dart';

class ProductoFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Producto? producto;

  ProductoFormProvider( this.producto );

  updateAvailability( bool value ) {
    this.producto?.disponible = value;
    notifyListeners();
  }

  bool isValidForm(){
    print( producto!.nombre);
    print( producto!.precio);
    print( producto!.disponible);

    return formKey.currentState?.validate() ?? false;
  }

  


}