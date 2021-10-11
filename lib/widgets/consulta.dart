import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:saguapac/model/deposito.dart';
import 'package:saguapac/provider/data_provider.dart';
import 'package:sizer/sizer.dart';

class Consulta extends StatefulWidget {
  const Consulta({Key? key}) : super(key: key);

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 3.w, top: 5.h),
          child: Row(
            children: [
              const Text(
                "COORDENADAS X:  ",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              Text(dataProvider.x.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 3.w, top: 5.h),
          child: Row(
            children: [
              const Text(
                "COORDENADAS Y:  ",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              Text(dataProvider.y.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 3.w, top: 5.h),
          child: Row(
            children: [
              const Text(
                "TAMANO:  ",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              Text(dataProvider.tamano.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 3.w, top: 5.h),
          child: Row(
            children: [
              const Text(
                "POTABLE:  ",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              Text(dataProvider.estado,
                  style: const TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
        ),

        Container(
            height: 10.h,
            width: 25.w,
            margin: EdgeInsets.only(left: 10.w, right: 3.w, top: 5.h),
            child: ElevatedButton(
                onPressed: () async {
                  final response = await http.get(Uri.parse(
                      'https://75jwlvujpd.execute-api.us-east-2.amazonaws.com/staging/expeditions/explore'));

                  if (response.statusCode == 200) {
                     deposit deposito =deposit.fromJson(jsonDecode(jsonDecode(response.body)['expedition']));
                     dataProvider.id=deposito.uniqueID;
                     dataProvider.x=deposito.x;
                     dataProvider.y=deposito.y;
                     dataProvider.tamano=deposito.tamano;
                     dataProvider.estado=randomChoice(["Es potable","No potable"]);
                     final firestoreInstance = FirebaseFirestore.instance;
                     firestoreInstance.collection("reporte").doc(dataProvider.id).set({
                       'uniqueID': dataProvider.id,
                       'x': dataProvider.x,
                       'y': dataProvider.y,
                       'tamano': dataProvider.tamano,
                       'estado': dataProvider.estado,
                       'date': Timestamp.fromDate(DateTime.now())
                     });
                  } else {
                    throw Exception('Failed to load deposit');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.white)),

                  primary: Colors.white, // background
                  onPrimary: Colors.white,
                ),
                child: const Text(
                  "Consultar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "MontserratSemiBold",
                    color: Colors.black,fontSize: 25
                  ),
                )







            )



        )
      ],
    );
  }
}
