import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProductStack(),
            _ProductForm()
          ],
        ),
      )
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),

    );
  }
}

class _ProductStack extends StatelessWidget {
  const _ProductStack({
    super.key,
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
            child: FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage('https://via.placeholder.com/400x300'),
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