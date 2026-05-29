import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderPage extends StatefulWidget {
  const FutureBuilderPage({super.key});

  @override
  State<FutureBuilderPage> createState() => _FutureBuilderPageState();
}

class _FutureBuilderPageState extends State<FutureBuilderPage> {
  late Future<List<String>> usuariosFuture;

  Future<List<String>> obtenerUsuarios() async {
    await Future.delayed(Duration(seconds: 5));

    return [
      "Ana Torees",
      "María Alfaro",
      "DSebastián Medina",
      "Frans Gallegos",
    ];
  }

  void recargarUsuarios() {
    usuariosFuture = obtenerUsuarios();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usuariosFuture = obtenerUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              recargarUsuarios();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: Text("Lista de usuarios"),
      ),
      body: FutureBuilder(
        future: usuariosFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("snapshot: $snapshot");
          print("Estado: ${snapshot.connectionState}");
          print("Has error: ${snapshot.hasError}");
          print("Erro: ${snapshot.error}");
          print("Has data: ${snapshot.hasData}");
          print("Data: ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final List<String> usuarios = snapshot.data;
            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (BuildContext context, int index) {
                final usuario = usuarios[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(usuario[0])),
                  title: Text(usuario),
                  subtitle: Text("Usuario activo"),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// // FutureBuilder -> Es un widget que construye la interfaz dependiendo del Future

// // Estados principales del  FutureBuilder son:
// //  1. connectionState.waiting -> El future todavía esta cargando
// //  2. snapshot.hasError -> El future terminó con un error
// //  3. snapshot.hasData -> el future terminó correctamente

// class FutureBuilderPage extends StatelessWidget {
//   const FutureBuilderPage({super.key});

//   Future<String> obtenerMensaje() async {
//     await Future.delayed(Duration(seconds: 4));
//     return "Datos cargados correctamente";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Futurebuilder example")),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             FutureBuilder(
//               future: obtenerMensaje(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Column(
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(height: 16),
//                       Text("Cargando información"),
//                     ],
//                   );
//                 }

//                 if (snapshot.hasError) {
//                   return Text(
//                     "Ocurrrió un error al cargar los datos",
//                     style: TextStyle(fontSize: 20, color: Colors.red),
//                   );
//                 }

//                 if (snapshot.hasData) {
//                   return Text(
//                     snapshot.data,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   );
//                 }
//                 return Text("No hay datos");
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
