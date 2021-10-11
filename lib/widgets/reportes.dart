import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saguapac/model/deposito.dart';
import 'package:sizer/sizer.dart';

class Reportes extends StatefulWidget {
  const Reportes({Key? key}) : super(key: key);

  @override
  _ReportesState createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  @override
  Widget build(BuildContext context) {
    List<Registro> registroProvider = Provider.of<List<Registro>>(context);
    return Container(
        margin: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
        child: ListView(
          children: [
            DataTable(
              columns:  const [
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(
                      fontFamily: "MontserratSemiBold",
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'COORDENADA X',
                    style: TextStyle(
                      fontFamily: "MontserratSemiBold",
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'COORDENADA Y',
                    style: TextStyle(
                      fontFamily: "MontserratSemiBold",
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'TAMAÑO',
                    style: TextStyle(
                      fontFamily: "MontserratSemiBold",
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ESTADO',
                    style: TextStyle(
                      fontFamily: "MontserratSemiBold",
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'FECHA',
                    style: TextStyle(
                      fontFamily: "MontserratSemiBold",
                    ),
                  ),
                ),
              ],
              rows: registroProvider
                  .map((e) => DataRow(
                        cells: [
                          DataCell(Text(e.uniqueID)),
                          DataCell(Text(e.x.toString())),
                          DataCell(Text(e.y.toString())),
                          DataCell(Text(e.tamano.toString())),
                          DataCell(Text(e.estado)),
                          DataCell(Text(
                              e.date.toDate().toString().substring(0, 16))),
                        ],
                      )).toList(),
            )
          ],
        ));
  }
}
