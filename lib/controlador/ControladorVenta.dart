import 'package:flutter/material.dart';
import 'package:avance_topicos/modelo/ModeloProducto2.dart';

class ControladorVentas {
  List<MProducto> carrito = [];
  List<Map<String, dynamic>> ventas = [];
  List<MProducto> productos = [];

  ControladorVentas() {
    // Inicializar los productos
    productos = MProducto.getAll();
  }

  List<MProducto> getCarrito() {
    return carrito;
  }

  Future<bool> agregarProducto(String id) async {
    var producto = productos.firstWhere(
      (p) => p.id == id,
      orElse: () => MProducto(nombre: '', id: '', cantidad: '1', precio: ''),
    );

    if (producto.nombre.isEmpty) {
      return false; // El producto no está disponible
    }

    // Verificar si hay suficiente cantidad en el almacén
    int cantidadDisponible = int.tryParse(producto.cantidad) ?? 0;
    if (cantidadDisponible <= 0) {
      return false; // No hay suficiente cantidad disponible
    }

    // Reducir la cantidad en el almacén
    cantidadDisponible--;
    producto.cantidad = cantidadDisponible.toString();

    // Actualizar el producto en la lista de productos
    int index = productos.indexWhere((p) => p.nombre == producto.nombre);
    if (index != -1) {
      productos[index] = producto;
    }

    // Agregar el producto al carrito
    carrito.add(producto);

    return true; // Producto agregado exitosamente
  }

  double calcularTotalVenta() {
    double total = 0;
    for (var producto in carrito) {
      total += double.tryParse(producto.precio) ?? 0;
    }
    return total;
  }

  void limpiarCarrito() {
    carrito.clear();
  }

  void pagar(BuildContext context, double totalVenta, VoidCallback updateState) {
    double? efectivo;

    // Muestra un diálogo para ingresar el monto en efectivo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pagar'),
          content: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Monto en efectivo'),
            onChanged: (value) {
              efectivo = double.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (efectivo != null) {
                  double cambio = efectivo! - totalVenta;
                  if (cambio >= 0) {
                    // Actualizar la cantidad en el almacén
                    for (var producto in carrito) {
                      int index = productos.indexWhere((p) => p.nombre == producto.nombre);
                      if (index != -1) {
                        int cantidadDisponible = int.tryParse(productos[index].cantidad) ?? 0;
                        cantidadDisponible--;
                        productos[index].cantidad = cantidadDisponible.toString();
                      }
                    }

                    // Agregar la venta a la lista de ventas
                    ventas.add({'id': ventas.length + 1, 'total': totalVenta}); // Simplemente agrega un objeto de venta con un ID y el total
                    limpiarCarrito(); // Limpiar el carrito después del pago exitoso
                    updateState(); // Actualizar la interfaz de usuario

                    // Cierra el diálogo de pagar
                    Navigator.of(context).pop();

                    // Muestra un diálogo de venta exitosa con el cambio
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('¡Pago exitoso!'),
                          content: Text('Cambio a devolver: \$${cambio.toStringAsFixed(2)}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cierra el diálogo
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Muestra un diálogo de error si el efectivo es insuficiente
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('El monto en efectivo es insuficiente.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cierra el diálogo
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: Text('Pagar'),
            ),
          ],
        );
      },
    );
  }
}
