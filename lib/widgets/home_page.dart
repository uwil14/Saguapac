import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
import 'package:saguapac/model/deposito.dart';
import 'package:saguapac/widgets/consulta.dart';
import 'package:saguapac/widgets/reportes.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final firestoreInstance = FirebaseFirestore.instance;

    Stream<List<Registro>> getRegistro() {
      return firestoreInstance
          .collection('reporte')
          .orderBy("date", descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((document) => Registro(
                  document['uniqueID'],
                  document['x'],
                  document['y'],
                  document['tamano'],
                  document['estado'],
                  document['date'],
                ))
            .toList();
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: Panorama(
                    animSpeed: 3.0,
                    child: Image.asset('images/marte.jpg'),
                  ),
                ),
                FadeInRight(
                    child: Container(
                  margin: EdgeInsets.only(left: 50.w),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.95),
                    ],
                    stops: const [0.0, 0.9],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  )),
                  height: 100.h,
                  width: 50.w,
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 10.w, top: 5.h, right: 3.w, bottom: 5.h),
                        alignment: Alignment.center,
                        child: const Text(
                          "SAGUAPAC",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MontserratExtraBold",
                              fontSize: 56),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10.w, right: 3.w),
                        child: const Text(
                          "El servicio de agua potable y alcantarillado del futuro hoy, nos encargamos de viabilizar la búsqueda de agua en nuestro planeta vecino, te invitamos a comprobar si en la ubicación que nos manda nuestra base en Marte hay agua potable.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const Consulta()
                    ],
                  ),
                )),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 100.h,
            width: 100.w,
            child: StreamProvider<List<Registro>>.value(
                value: getRegistro(),
                initialData: const [],
                child: const Reportes()),
          )
        ],
      ),
    );
  }
}
