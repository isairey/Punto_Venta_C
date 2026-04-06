import 'package:hive_flutter/adapters.dart';

class MProducto {
  String nombre;
  String cantidad;
  String id;
  String precio;

  MProducto({
    required this.nombre,
    required this.id,
    required this.cantidad,
    required this.precio,
  });

  factory MProducto.fromJson(Map<dynamic, dynamic> json) {
    return MProducto(
      nombre: json['Nombre'] ?? '',
      id: json['ID'] ?? '',
      cantidad: json['Cantidad'] ?? '',
      precio: json['Precio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Nombre': nombre,
    'ID': id,
    'Cantidad': cantidad,
    'Precio': precio,  
  };

  @override
  String toString() {
    return 'Producto{Nombre: $nombre, ID: $id, Cantidad: $cantidad, Precio: $precio}';
  }

  void save() async {
    var box = await Hive.openBox('productos');
    box.put(id, toJson());
    var productos = box.values.toList();
    print(productos);
  }

  void update(String id) {
    Hive.box('productos').put(id, toJson());
  }

  void delete(String id) {
    Hive.box('productos').delete(id);
  }

  static List<MProducto> getAll() {
    var productos = Hive.box('productos').values.toList();
    return productos.map((p) => MProducto.fromJson(p)).toList();
  }

  toMap() {}
}
