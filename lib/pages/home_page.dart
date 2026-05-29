import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> obtenerNombre() async {
    print("Obteniendo nombre");
    await Future.delayed(Duration(seconds: 2));
    return "Jhonny";
  }

  Future<String> tarea1() {
    return Future.delayed(Duration(seconds: 4), () {
      return "Tarea 1 completada";
    });
  }

  // Ejemplo con error
  Future<String> obtenerDatos() async {
    await Future.delayed(Duration(seconds: 3));
    throw Exception("Error al conectar con el servidor");
    // return "estos son lo datos";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            print("Cargando....");
            final datos = await obtenerDatos();
            print(datos);
          } catch (error) {
            print("Ocurríó un error: $error");
          }

          //  Esto es incorrecto cuando devuelve un error
          // obtenerDatos().then((elDato) {
          //   print(elDato);
          // });

          // // Manera 1 de acceder al contenido de un future
          // tarea1().then((nombre) {
          //   print(nombre);
          // });

          // // Manera 2 de acceder al contenido de un future
          // String nombre = await obtenerNombre();
          // print(nombre);
        },
      ),
    );
  }
}
