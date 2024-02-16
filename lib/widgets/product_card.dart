import 'package:flutter/material.dart';
import 'package:flutter_crud/models/models.dart';

class ProductCard extends StatelessWidget {

  final Producto producto;

  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 400,
        margin: EdgeInsets.only( top: 30, bottom: 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0,7),
              blurRadius: 10,
            )
          ]
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(
              url: producto.imagen
            ),
            _ProductDetails(
              nombre: producto.nombre,
              id: producto.id!,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                precio: producto.precio,
              )
            ),
            if(producto.disponible == false)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable())
          ],
        ),
      ),
    );
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
      child: Text('No disponible', style: TextStyle(color: Colors.white, fontSize: 15),),

    );
  }
}

class _PriceTag extends StatelessWidget {

  final double precio;

  const _PriceTag({
    super.key, required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only( topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: Text(
        '$precio€',
        style: TextStyle(fontSize: 20, color:Colors.white),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String nombre;
  final String id;

  const _ProductDetails({
    super.key, required this.nombre, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 70,
      
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25) )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombre,
            style: TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            id,
            style: TextStyle( fontSize: 15, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  
  final String? url;

  const _BackgroundImage({
    super.key, this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
        ? Image(
          image: AssetImage('assets/no-image.jpg'),
          fit: BoxFit.cover,
        ) 
        : FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}