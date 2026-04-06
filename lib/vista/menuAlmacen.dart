import 'package:avance_topicos/vista/Altas.dart';
import 'package:avance_topicos/vista/Bajas.dart';
import 'package:avance_topicos/vista/VerProductos.dart';
import 'package:avance_topicos/vista/inicio.dart';
import 'package:flutter/material.dart';


class menuAlmacen extends StatefulWidget{
  const menuAlmacen({super.key});

  State<menuAlmacen> createState() => _menuAlmacenState();

}

class _menuAlmacenState extends State<menuAlmacen>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menú Almacen',
          style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.blue[250],
            ),
  body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 107, 211, 103)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push( context,  MaterialPageRoute(builder: (context) => AltasPro(productos: [],)));
                  },
                  child: const Text(
                    'Altas',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 252, 110, 110)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                   Navigator.push( context,  MaterialPageRoute(builder: (context) => Bajas()));
                  },
                  child: const Text(
                    'Bajas',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 49, 96, 250)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VerProductos()));
                  },
                  child: const Text(
                    'Ver Productos',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),                
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 22, 162, 255)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                  Navigator.pushReplacement( context,  MaterialPageRoute(builder: (context) => inicio()));
                  },
                  child: const Text(
                    'Regresar',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ]
           ),

          ],
        ),
      ),
    );
  }
}
