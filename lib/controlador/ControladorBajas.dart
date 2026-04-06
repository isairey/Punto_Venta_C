import 'package:hive_flutter/hive_flutter.dart';

class ControladorBajas {
  void eliminarProducto(String id) async {
    // Inicializa Hive
    await Hive.initFlutter();

    // Abre la caja de productos
    //final productosBox = await Hive.openBox('productos');

    // Elimina el producto con el ID proporcionado
    Hive.box('productos').delete(id);

    // Cierra la caja después de usarla
    //await productosBox.close();
  }
}