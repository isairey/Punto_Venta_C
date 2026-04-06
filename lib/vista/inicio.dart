import 'package:avance_topicos/vista/menuAlmacen.dart';
import 'package:avance_topicos/vista/menuVentas.dart';
import 'package:flutter/material.dart';

class inicio extends StatefulWidget{
  const inicio({super.key});

  State<inicio> createState() => _inicioState();

}

class _inicioState extends State<inicio>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
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
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 120, 128, 240)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement( context,  MaterialPageRoute(builder: (context) => (menuAlmacen())));  
                  },
                  child: const Text(
                    'Almacen',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),     
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => (menuVentas())));
                  },
                  child: const Text(
                    'Ventas',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
