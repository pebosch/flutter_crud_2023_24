import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/screens.dart';
import 'package:flutter_crud/widgets/widgets.dart';
import 'package:flutter_crud/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productosServices = Provider.of<ProductosServices>(context);

    if( productosServices.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productosServices.producto.length,
        itemBuilder: ( BuildContext context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard(
            producto:productosServices.producto[index],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:(){

        },
      ),
   );
  }
}