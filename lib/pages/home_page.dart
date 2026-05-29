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

  // Otro ejemplo con error
  Future<int> dividir(int a, int b) async {
    print("Analizando división");
    if (b == 0) {
      throw Exception("No se puede dividir entre cero");
    }
    await Future.delayed(Duration(seconds: 2));
    return a ~/ b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Ejemplo usando dividir()
          try {
            final int resultado = await dividir(10, 0);
            print("el resultado de la división es: $resultado");
          } catch (e) {
            print("Hubo un error: $e");
          }

          // ----------------------------------------------------------------------------------
          // Ejemplo usando obtenerDatos()
          // try {
          //   print("Cargando....");
          //   final datos = await obtenerDatos();
          //   print(datos);
          // } catch (error) {
          //   print("Ocurríó un error: $error");
          // }

          // ----------------------------------------------------------------------------------
          //  Esto es incorrecto cuando devuelve un error
          // obtenerDatos().then((elDato) {
          //   print(elDato);
          // });

          // ----------------------------------------------------------------------------------
          // // Manera 1 de acceder al contenido de un future
          // tarea1().then((nombre) {
          //   print(nombre);
          // });

          // ----------------------------------------------------------------------------------
          // // Manera 2 de acceder al contenido de un future
          // String nombre = await obtenerNombre();
          // print(nombre);
        },
      ),
    );
  }
}
