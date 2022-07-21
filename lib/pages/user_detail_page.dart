import 'package:bo_cracity/widgets/data_table_details.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../services/api_services.dart';
import '../services/user_detail.dart';
import '../widgets/data_table.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<UserDetail> createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail de l'utilisteur"),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  ApiServices.addFavorite(widget.username);
                },
                child: Text("ajouter aux favoris")),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.red)
                      )
                  )
              ),
              onPressed: () {
                ApiServices.banUser(widget.username);

                //action code for button 2
              },
              child: Text("Bannir l'utilisateur"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.orangeAccent)
                      )
                  )
              ),
              onPressed: () {
                ApiServices.unbanUser(widget.username);

                //action code for button 2
              },
              child: Text("Débannir l'utilisateur"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiServices.getUserDetail(widget.username),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                if (snapshot.hasData) {
                  final List<UserD> users = snapshot.data;
                  if (users.isEmpty) {
                    return const Center(
                      child: Text("Empty list"),
                    );
                  }
                  return DataTableDetailsWidget(users: users);
                } else {
                  return const Center(
                    child: Text("No data"),
                  );
                }
                break;
              default:
                return Container();
                break;
            }
          },
        ),
      ),
    );
  }
}
