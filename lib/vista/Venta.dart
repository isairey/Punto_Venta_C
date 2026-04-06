import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:avance_topicos/controlador/ControladorVenta.dart'; // Importa la clase ControladorVentas

class VistaVenta extends StatefulWidget {
  @override
  _VistaVentaState createState() => _VistaVentaState();
}

class _VistaVentaState extends State<VistaVenta> {
  final ControladorVentas carrito = ControladorVentas(); // Usa la clase ControladorVentas
  TextEditingController Nombre = TextEditingController();
  String pdfPath = '';

  double get totalVenta => carrito.calcularTotalVenta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ventas')),
      body: Column(
        children: [
          TextField(
            controller: Nombre,
            decoration: const InputDecoration(
              labelText: 'Nombre del producto',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String nombreProducto = Nombre.text;
              print('Intentando agregar producto con nombre: $nombreProducto');
              bool result = await carrito.agregarProducto(nombreProducto);
              if (!result) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('El producto "$nombreProducto" no se pudo agregar al carrito.'),
                ));
              } else {
                print('Producto "$nombreProducto" agregado al carrito.');
                Nombre.clear();
                setState(() {});
              }
            },
            child: Text('Agregar al carrito'),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: carrito.carrito.isEmpty
                  ? const Center(child: Text('No hay productos en el carrito'))
                  : ListView.builder(
                      itemCount: carrito.carrito.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(carrito.carrito[index].nombre),
                          subtitle: Text(
                              'Precio: ${carrito.carrito[index].precio}'),
                        );
                      },
                    ),
            ),
          ),
          Text(
            'Total de la venta: \$${totalVenta.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () async {
              // Realizar el pago
              carrito.pagar(context, totalVenta, () {
                // Llama a la función de devolución de llamada después del pago exitoso
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Venta exitosa'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(16),
                  shape: StadiumBorder(),
                  elevation: 10,
                  padding: EdgeInsets.all(20),
                  dismissDirection: DismissDirection.horizontal,
                ));

                // Exportar la transacción a PDF
                _exportarVentaAPDF();
              });
            },
            child: const Text('Pagar'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportarVentaAPDF() async {
    final pdf = pw.Document();

    // Agregar contenido al PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('Detalle de la venta', style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 20),
                pw.Text('Productos en el carrito:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                for (var producto in carrito.carrito)
                  pw.Text('${producto.nombre} - \$${producto.precio}'),
                pw.SizedBox(height: 20),
                pw.Text('Total de la venta: \$${totalVenta.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );

    //Guardar el PDF
    final directory = await getExternalStorageDirectory();
    final String path = '${directory?.path}/venta.pdf';
    final file = File(path);
    final pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes);
    print('PDF generado en: $path');
  
  }
}
