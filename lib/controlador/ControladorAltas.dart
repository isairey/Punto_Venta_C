import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ControladorAltas {
  void agregarProducto({
    required String id,
    required String nombre,
    required String precio,
    required String cantidad,
  }) async {
    //1.- validar mis datos (entrada)

    //2.- Inicializar Hive
    await Hive.initFlutter();

    //3.- Abrir la caja 'productos'
    final productosBox = await Hive.openBox('productos');

    //4.- Guardar en la base de datos
    productosBox.put(
      id,
      {
        'id': id,
        'nombre': nombre,
        'precio': precio,
        'cantidad': cantidad,
      },
    );


    //5.- Cerrar la caja después de usarla
    await productosBox.close();
  }
}