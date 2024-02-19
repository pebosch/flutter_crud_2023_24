import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/providers/producto_form_provider.dart';
import 'package:flutter_crud/services/productos_services.dart';
import 'package:flutter_crud/ui/input_decorations.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductosServices>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductoFormProvider( productService.productoSeleccionado),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductosServices productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductoFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            _ProductStack( url: productService.productoSeleccionado?.imagen ),
            _ProductForm(),
          ],
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        child: Icon ( Icons.save_outlined),
        onPressed: () async {
          if ( !productForm.isValidForm() ) return;

          await productService.saveOrCreateProducto(productForm.producto!);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductoFormProvider>(context);
    final producto = productForm.producto;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        //height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0,5),
              blurRadius: 5
            )
          ]
        ),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox( height: 10),
              TextFormField(
                initialValue: producto?.nombre,
                onChanged: (value) => producto?.nombre = value,
                validator: (value) {
                  if ( value == null || value.length < 1 )
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre: ',
                ),
              ),
              SizedBox( height: 30),
              TextFormField(
                initialValue: '${producto?.precio}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if( double.tryParse(value) == null) {
                    producto?.precio = 0;
                  } else {
                    producto!.precio = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '150€',
                  labelText: 'Precio: ',
                ),
              ),
              SizedBox( height: 30),
              SwitchListTile.adaptive(
                value: producto!.disponible, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productForm.updateAvailability
              ),
              SizedBox( height: 30),
            ],
          )
          ),
      ),
    );
  }
}

class _ProductStack extends StatelessWidget {

  final String? url;

  const _ProductStack({
    super.key, this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: double.infinity,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0,5)
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: this.url == null
            ? Image(
              image: AssetImage('assets/no-image.jpg'),
              fit: BoxFit.cover,
            ) 
          : FadeInImage(
              image: NetworkImage(this.url!),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        top: 60,
        left: 20,
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon (Icons.arrow_back_rounded, size: 40, color: Colors.white,)
        )
      ),
      Positioned(
        top: 60,
        right: 20,
        child: IconButton(
          onPressed: () {},
          icon: Icon (Icons.camera_alt_outlined, size: 40, color: Colors.white,)
        )
      ),
      ]
    );
  }
}