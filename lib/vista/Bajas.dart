import 'package:flutter/material.dart';
import 'package:avance_topicos/controlador/ControladorBajas.dart';

class Bajas extends StatelessWidget {
  final ControladorBajas controladorBajas = ControladorBajas();
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bajas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID del producto'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String id = idController.text;
                controladorBajas.eliminarProducto(id);
              },
              child: Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
