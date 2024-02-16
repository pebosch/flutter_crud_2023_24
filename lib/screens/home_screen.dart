import 'package:flutter/material.dart';
import 'package:flutter_crud/widgets/widgets.dart';
import 'package:flutter_crud/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productosServices = Provider.of<ProductosServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ( BuildContext context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard()
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