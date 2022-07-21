import 'package:flutter/material.dart';

import '../pages/user_detail_page.dart';
import '../services/api_services.dart';
import '../services/api_services.dart';
import '../services/user.dart';

class DataSondageTableWidget extends StatefulWidget {
  const DataSondageTableWidget({Key? key, required this.sondages}) : super(key: key);
  final List<dynamic> sondages;

  @override
  State<DataSondageTableWidget> createState() => _DataSondageTableWidget();
}

class _DataSondageTableWidget extends State<DataSondageTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 15,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            horizontalMargin: 15,
            columns: const [
              DataColumn(label: Text("Titre")),
              DataColumn(label: Text("Nombre de Choix")),
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("Nombre de signalement")),
            ],
            rows: widget.sondages
                .map((e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.title.toString()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),
                        DataCell(
                          Text(e.numberchoices.toString()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),

                        DataCell(
                          Text((() {
                            if (e.private.toString()=="true") {
                              return "Salle privée";
                            }
                            return "Sondage Public";
                          })()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),
                        DataCell(
                          Text(e.isreported.toString()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),
                      ],
                    ))
                .toList(),
            headingRowColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
            headingTextStyle: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    );
  }
}
void _goToUserDetail(BuildContext context, String username) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => UserDetail(username: username),
    ),
  );
}
