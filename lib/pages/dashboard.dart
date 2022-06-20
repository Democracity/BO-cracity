import 'package:bo_cracity/pages/page1.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../services/user.dart';
import '../services/api_services.dart';
import '../services/user_item.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController page = PageController();
  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData('Android', 25, Colors.blue.shade700),
      ChartData('IOS', 38, Colors.red),
      ChartData('Flutter', 34, Colors.green.shade900),
    ];
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),

            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bo_cracity',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {
                  _goToPage1(context);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Utilisateurs',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Utilisateurs IOS',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: const Icon(Icons.account_circle_rounded),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Utilisateurs Android',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: const Icon(Icons.android_outlined),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Sondages',
                onTap: ()  {
                  page.jumpToPage(4);
                },
                icon: const Icon(Icons.stacked_bar_chart),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                SfCircularChart(
                    legend: Legend(isVisible: true),


                    title: ChartTitle(
                        text: 'Graphique utilisateurs',
                        // Aligns the chart title to left
                        alignment: ChartAlignment.near,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        )
                    ),
                  backgroundColor: Colors.grey,
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper:(ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings: const DataLabelSettings(isVisible: true)
                      )
                    ]
                ),
                Scaffold(
                  body: SafeArea(
                    child: FutureBuilder(
                      future: ApiServices.getUsers(),
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
                              final List<User> users = snapshot.data;
                              if (users.isEmpty) {
                                return const Center(
                                  child: const Text("Empty list"),
                                );
                              }
                              return ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return UserItem(
                                    user: users[index],
                                  );
                                },
                              );
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
                ),
                Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _goToPage1(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => const Page1(),
    ),
  );
}


class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}