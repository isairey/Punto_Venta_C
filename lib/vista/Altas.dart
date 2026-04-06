import 'package:avance_topicos/controlador/GuardarProductosC.dart';
import 'package:flutter/material.dart';
//import 'package:avance_topicos/controlador/ControladorAltas.dart';
import 'package:avance_topicos/modelo/Productos.dart';

class AltasPro extends StatelessWidget {
  final List<Producto> productos;
  
  final GuardarProductosController controlProductos = GuardarProductosController();
  AltasPro({Key? key, required this.productos}) : super(key: key);

  final TextEditingController ID = TextEditingController();
  final TextEditingController Nombre = TextEditingController();
  final TextEditingController Precio = TextEditingController();
  final TextEditingController Cantidad= TextEditingController();
  //final ControladorAltas agregarProductosController = ControladorAltas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Altas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: ID,
              decoration: const InputDecoration(labelText: 'ID del producto'),
            ),
            TextFormField(
              controller: Nombre,
              decoration: const InputDecoration(labelText: 'Nombre del producto'),
            ),
            TextFormField(
              controller: Precio,
              decoration: const InputDecoration(labelText: 'Precio del producto'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: Cantidad,
              decoration: const InputDecoration(labelText: 'Cantidad de producto'),
              keyboardType: TextInputType.number,
            ),
 
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // ignore: unused_local_variable
                var guardar = controlProductos.guardarProducto(
                  nombre: Nombre.text,
                  id: ID.text, 
                  cantidad: Cantidad.text,
                  precio: Precio.text,
                );
              },
              child: const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
