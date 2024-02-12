import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/screens.dart';
import 'package:flutter_crud/services/productos_services.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(AppState());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        'login': ( _ ) => LoginScreen(),
        'home' : ( _ ) => HomeScreen(),
        'product' : ( _ ) => ProductScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Colors.indigo
        )
      ),
    );
  }
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductosServices())
      ],
      child: MyApp(),
    );
  }
}