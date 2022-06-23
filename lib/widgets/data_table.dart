import 'package:flutter/material.dart';

import '../pages/user_detail_page.dart';
import '../services/user.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({ Key? key , required this.users}) : super(key: key);
  final List<dynamic> users;

  @override
  State<DataTableWidget> createState() => _DataTableWidget();
}

class _DataTableWidget extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(columnSpacing: 38.0, columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Mail')),
        DataColumn(label: Text('Password')),

      ], rows: widget.users.map((e) => DataRow(
          cells: [
            DataCell(Text(e.username), onTap: (){
              _goToUserDetail(context, e.username);
              print('DataCell onTap');

      },),
            DataCell(Text(e.mail), onTap: (){
              print('DataCell onTap');
            },),
            DataCell(Text(e.password), onTap: (){
              print('DataCell onTap');
            },),
          ],

      )).toList(),
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