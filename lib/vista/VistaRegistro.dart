import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  late Box _ventaBox;
  late Future<List<Map<String, dynamic>>> _ventasFuture;

  @override
  void initState() {
    super.initState();
    _inicializarBox();
  }

  Future<void> _inicializarBox() async {
    final Directory directorio = await getApplicationDocumentsDirectory();
    Hive.init(directorio.path);
    _ventaBox = await Hive.openBox('ventas');
    _ventasFuture = _obtenerVentas();
  }

  Future<void> _agregarVenta(Map<String, dynamic> venta) async {
    await _ventaBox.add(venta);
    setState(() {
      _ventasFuture = _obtenerVentas();
    });
  }

  Future<List<Map<String, dynamic>>> _obtenerVentas() async {
    List<Map<String, dynamic>> ventas = [];
    for (int i = 0; i < _ventaBox.length; i++) {
      ventas.add(Map.from(_ventaBox.getAt(i) as Map));
    }
    return ventas;
  }

  Future<List<Map<String, dynamic>>> _obtenerVentasOrdenadasPorId() async {
    List<Map<String, dynamic>> ventas = _ventaBox.values.toList().cast<Map<String, dynamic>>();
    ventas.sort((a, b) => b['id'].compareTo(a['id']));
    return ventas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Ventas'),
      ),
      body: FutureBuilder(
        future: _ventasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> registros = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: registros.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> registro = registros[index];
                return ListTile(
                  title: Text('Venta #${index + 1}'),
                  subtitle: Text('Total: \$${registro['total']}'),
                  onTap: () {
                    // Aquí puedes mostrar los detalles de la venta al hacer clic
                    // Por ejemplo, puedes navegar a una nueva pantalla con los detalles de la venta
                    // o mostrar un diálogo con los detalles.
                    // Dependerá de cómo quieras implementarlo.
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
