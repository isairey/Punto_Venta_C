import 'package:avance_topicos/modelo/ModeloProducto2.dart';

class GuardarProductosController {
  void guardarProducto({
    required String nombre,
    required String id,
    required String cantidad,
    required String precio,
  }) {
    // validar el precio [quedó pendiente]
    // mediante try catch ó regex (mejor regex)

    MProducto producto = MProducto(
      nombre: nombre,
      id: id,
      cantidad: cantidad,
      precio: precio,
    );

    producto.save();
  }
}