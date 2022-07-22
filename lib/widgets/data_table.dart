import 'package:flutter/material.dart';

import '../pages/user_detail_page.dart';
import '../services/api_services.dart';
import '../services/api_services.dart';
import '../services/user.dart';

class DataTableWidget extends StatefulWidget {
  DataTableWidget({Key? key, required this.users}) : super(key: key);
  List<dynamic> users;

  @override
  State<DataTableWidget> createState() => _DataTableWidget();
}

class _DataTableWidget extends State<DataTableWidget> {
  bool isAscending = true;
  int selectedIndex = 3;

  String regionSelected = "Toutes les regions";
  List<String> regionChoices = [
    "Toutes les regions",
    "Bretagne",
    "Ile-de-France"
  ];

  String statusSelected = "Tout";
  List<String> statusChoices = [
    "Tout",
    "Actif",
    "Bannis"
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("Filtre Régions:"),
                  const SizedBox(width: 5,),
                  DropdownButton<String>(
                    value: regionSelected,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),

                    items: regionChoices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint: const Text(
                      "Regions",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value) async{
                      regionSelected = value!;
                      if(regionSelected != null){
                        //api
                        List<dynamic> newUsers = await ApiServices.getUsersByRegion(regionSelected);

                        setState(() {
                          widget.users = newUsers;
                        });
                      } else {

                        print("çq ,qrjgychhe pobnn,");
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(width: 20,),
              Row(
                children: [
                  Text("Filtres Etat du compte:"),
                  const SizedBox(width: 5,),
                  DropdownButton<String>(
                    value: statusSelected,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),

                    items: statusChoices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint: const Text(
                      "Regions",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value) async{
                      statusSelected = value!;
                      if(statusSelected != null){
                        String choice;
                        switch (statusSelected){
                          case "Actif":
                            choice = "false";
                            break;
                          case "Bannis":
                            choice = "true";
                            break;
                          default:
                            choice = "Tout";
                        }
                          //api
                          List<dynamic> newUsers = await ApiServices.getUsersbyStatus(choice);
                          setState(() {
                            widget.users = newUsers;
                          });
                      } else {

                        print("çq ,qrjgychhe pobnn,");
                      }
                    },
                  ),
                ],
              ),
            ],
          )
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 5,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            elevation: 15,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  sortAscending: isAscending,
                  sortColumnIndex: selectedIndex,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  horizontalMargin: 15,
                  columns: [
                    DataColumn(
                        label: const Text("Pseudo"),
                        onSort: (columIndex, ascending) {
                          setState(() {
                            selectedIndex = 0;
                            isAscending = ascending;

                            ascending
                                ? widget.users.sort(
                                    (a, b) => a.username.compareTo(b.username))
                                : widget.users.sort(
                                    (a, b) => b.username.compareTo(a.username));
                          });
                        }),
                    const DataColumn(label: Text("Mail")),
                    DataColumn(
                        label: Text("Region"),
                        onSort: (columIndex, ascending) {
                          setState(() {
                            selectedIndex = 2;
                            isAscending = ascending;
                            ascending
                                ? widget.users
                                    .sort((a, b) => a.region.compareTo(b.region))
                                : widget.users
                                    .sort((a, b) => b.region.compareTo(a.region));
                          });
                        }),
                    DataColumn(
                        label: const Text("Points"),
                        onSort: (columIndex, ascending) {
                          setState(() {
                            selectedIndex = 3;

                            isAscending = ascending;
                            ascending
                                ? widget.users
                                    .sort((a, b) => a.points.compareTo(b.points))
                                : widget.users
                                    .sort((a, b) => b.points.compareTo(a.points));
                          });
                        }),
                    const DataColumn(label: Text("Status")),
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
                                  if (e.region.toString() == "null" ||
                                      e.region.toString() == "undefined") {
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
                                  if (e.isbanned.toString() == "false") {
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
          ),
        ),
      ],
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
