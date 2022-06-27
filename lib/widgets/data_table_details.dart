import 'package:flutter/material.dart';

import '../pages/user_detail_page.dart';
import '../services/user.dart';

class DataTableDetailsWidget extends StatefulWidget {
  const DataTableDetailsWidget({ Key? key , required this.users}) : super(key: key);
  final List<dynamic> users;

  @override
  State<DataTableDetailsWidget> createState() => _DataTableDetailsWidget();
}

class _DataTableDetailsWidget extends State<DataTableDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(columnSpacing: 38.0, columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Mail')),
        DataColumn(label: Text('Password')),
        DataColumn(label: Text('Plateform')),
        DataColumn(label: Text('Sondages Répondus')),
        DataColumn(label: Text('Favoris')),


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
            DataCell(Text(e.role.toString()), onTap: (){
              print('DataCell onTap');
            },),
            DataCell(Text(e.sondageansweredid.toString()), onTap: (){
              print('DataCell onTap');
            },),
            DataCell(Text(e.favorite.toString()), onTap: (){
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