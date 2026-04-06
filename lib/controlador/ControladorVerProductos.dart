import 'package:avance_topicos/modelo/Productos.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ControladorVerProductos {
  Future<List<Producto>> verProductos() async {
    // Inicializa Hive
    await Hive.initFlutter();
    
    // Abre la caja de productos
    final productosBox = await Hive.openBox('productos');
    
    if (productosBox.isNotEmpty) {
      List<Producto> listaProductos = [];      
      for (var i = 0; i < productosBox.length; i++) {
        listaProductos.add(
          Producto(
            id: productosBox.getAt(i)['id'],
            nombre: productosBox.getAt(i)['nombre'],
            precio: double.parse(productosBox.getAt(i)['precio']),
            cantidad: int.parse(productosBox.getAt(i)['cantidad']),
          ),
        );
      }      
      await productosBox.close();      
      return listaProductos;
    }
    return [];
  }
  
}
