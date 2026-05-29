import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futureappg15/models/product_model.dart';

class ConsultaProductosPage extends StatefulWidget {
  @override
  State<ConsultaProductosPage> createState() => _ConsultaProductosPageState();
}

class _ConsultaProductosPageState extends State<ConsultaProductosPage> {
  late Future<List<ProductModel>> productsFuture;

  Future<List<ProductModel>> obtenerProductos() async {
    await Future.delayed(Duration(seconds: 3));
    return [
      ProductModel(nombre: "Laptop", precio: 2500.00, stock: 5),
      ProductModel(nombre: "Mouse", precio: 80.5, stock: 15),
      ProductModel(nombre: "Teclado", precio: 105.00, stock: 8),
      ProductModel(nombre: "Monitor Gamingn", precio: 720, stock: 3),
    ];
  }

  void recargarProductos() {
    productsFuture = obtenerProductos();
    setState(() {});
  }

  Color obtenerColorStock(int stock) {
    if (stock <= 3) {
      return Colors.red;
    } else if (stock <= 8) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String obtenerTextoStock(int stock) {
    if (stock <= 3) {
      return "Stock Bajo";
    } else if (stock <= 8) {
      return "Stock Medio";
    } else {
      return "Stock Alto";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsFuture = obtenerProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              recargarProductos();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: Text("Productos"),
      ),
      body: FutureBuilder(
        future: productsFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Cargando productos...."),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar productos",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay productos diponibles"));
          } else {
            final List<ProductModel> productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (BuildContext context, int index) {
                final ProductModel producto = productos[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: obtenerColorStock(producto.stock),
                      child: Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                    title: Text(
                      producto.nombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("S/ ${producto.precio.toStringAsFixed(2)}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          producto.stock.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: obtenerColorStock(producto.stock),
                          ),
                        ),
                        Text(
                          obtenerTextoStock(producto.stock),
                          style: TextStyle(
                            fontSize: 15,
                            color: obtenerColorStock(producto.stock),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
