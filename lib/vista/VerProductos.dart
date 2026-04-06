import 'package:avance_topicos/modelo/ModeloProducto2.dart';
import 'package:flutter/material.dart';
import 'package:avance_topicos/controlador/ControladorVerProductos.dart';

class VerProductos extends StatefulWidget {
  @override
  _VerProductosState createState() => _VerProductosState();
  
}

class _VerProductosState extends State<VerProductos> {
  final ControladorVerProductos verProductosController = ControladorVerProductos();
  List<MProducto> Lproductos = MProducto.getAll();

  @override
  void initState() {
    super.initState();
    //_cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ver productos')),
      body: Center(
        child: Lproductos.isEmpty
            ? CircularProgressIndicator()
            : Lproductos.isEmpty
                ? Text('No hay productos disponibles')
                : ListView.builder(
                    itemCount: Lproductos.length,
                    itemBuilder: (context, index) {
                      MProducto producto = Lproductos[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(producto.id),
                        ),
                        title: Text(producto.nombre),
                        subtitle: Text('\$${producto.precio}'),
                        trailing: Text('x${producto.cantidad}'),
                        onTap: () {}, 
                      );
                    },
                  ),
      ),
    );
  }
}
