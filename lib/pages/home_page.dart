import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mensaje = "Presiona el botón para cargar los datos";

  bool cargando = false;

  Future<String> cargarNombreUsuario() async {
    await Future.delayed(Duration(seconds: 3));
    // return "Jhonny Gallegos";
    throw Exception("No se puede cargar al usuario");
  }

  Future<void> obtenerUsuario() async {
    setState(() {
      cargando = true;
      mensaje = "cargando usuario";
    });

    try {
      final nombre = await cargarNombreUsuario();

      setState(() {
        mensaje = "Usuario cargado: $nombre";
        cargando = false;
      });
    } catch (error) {
      setState(() {
        mensaje = "error: No se pudo cargar al usuario";
        cargando = false;
      });
    }
  }

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
          } catch (e, stack) {
            print("Hubo un error: $e"); //es el error
            print(
              "Stack: $stack",
            ); //me ayuda a encontrar dónde ha ocurrido el error
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
      appBar: AppBar(title: Text("Programación Asíncrona")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (cargando == true)
                CircularProgressIndicator()
              else
                Icon(Icons.person, size: 80, color: Colors.blue),
              SizedBox(height: 24),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: cargando == true ? null : obtenerUsuario,
                child: Text("Cargar usuario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
