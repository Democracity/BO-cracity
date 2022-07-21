import 'package:flutter/material.dart';

import '../pages/user_detail_page.dart';
import '../services/api_services.dart';
import '../services/api_services.dart';
import '../services/user.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({Key? key, required this.users}) : super(key: key);
  final List<dynamic> users;

  @override
  State<DataTableWidget> createState() => _DataTableWidget();
}

class _DataTableWidget extends State<DataTableWidget> {
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
              DataColumn(label: Text("Pseudo")),
              DataColumn(label: Text("Mail")),
              DataColumn(label: Text("Region")),
              DataColumn(label: Text("Points")),
              DataColumn(label: Text("Status")),
            ],
            rows: widget.users
                .map((e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.username.toString()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),
                        DataCell(
                          Text(e.mail.toString()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),

                        DataCell(
                          Text((() {
                            if (e.region.toString()=="null" || e.region.toString() == "undefined") {
                              return "Non renseigné";
                            }
                            return e.region.toString();
                          })()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),
                        DataCell(
                          Text(e.points.toString()),
                          onTap: () {
                            print('DataCell onTap');
                          },
                        ),
                        DataCell(
                          Text((() {
                            if (e.isbanned.toString()=="false") {
                              return "Actif";
                            }
                            return "Bannis";
                          })()),
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
