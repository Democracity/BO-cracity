import 'package:bo_cracity/pages/page1.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../services/user.dart';
import '../services/api_services.dart';
import '../widgets/data_table.dart';
import '../widgets/user_item.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.admin}) : super(key: key);
  final String admin;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController page = PageController();

  void _updateFavorite() {
    setState(() {
      page.jumpToPage(4);

    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Android', 25, Colors.blue.shade700),
      ChartData('IOS', 38, Colors.red),
      ChartData('Flutter', 34, Colors.green.shade900),
    ];

    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.admin),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            onDisplayModeChanged: (mode) {},
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              backgroundColor: Colors.blue,
              selectedColor: Colors.white,
              selectedTitleTextStyle: const TextStyle(color: Colors.black),
              selectedIconColor: Colors.black,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Back Office',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Accueil',
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
                onTap: () {
                  _updateFavorite();
                },
                icon: const Icon(Icons.stacked_bar_chart),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Favoris',
                onTap: (

                    ) {

                  page.jumpToPage(5);
                },
                icon: const Icon(Icons.star),
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
                      "J'aime trop Flutter",
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
                        )),
                    backgroundColor: Colors.white,
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ]),
                Scaffold(
                  body: SafeArea(
                    child: FutureBuilder(
                      future: ApiServices.getAndroidUsers(),
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
                                  child: Text("Empty list"),
                                );
                              }
                              return DataTableWidget(users: users);
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
                Scaffold(
                  body: SafeArea(
                    child: FutureBuilder(
                      future: ApiServices.getiosUsers(),
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
                                  child: Text("Empty list"),
                                );
                              }

                              return DataTableWidget(users: users);


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
                Scaffold(
                  body: Column(
                    children: [
                      //Initialize the chart widget
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(text: 'sondages stats'),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales',
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          //Initialize the spark charts widget
                          child: SfSparkLineChart.custom(
                            //Enable the trackball
                            trackball: const SparkChartTrackball(
                                activationMode: SparkChartActivationMode.tap),
                            //Enable marker
                            marker: const SparkChartMarker(
                                displayMode: SparkChartMarkerDisplayMode.all),
                            //Enable data label
                            labelDisplayMode: SparkChartLabelDisplayMode.all,
                            xValueMapper: (int index) => data[index].year,
                            yValueMapper: (int index) => data[index].sales,
                            dataCount: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Scaffold(
                  body: SafeArea(
                    child: FutureBuilder(
                      future: ApiServices.getFavorites(),
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
                                  child: Text("Empty list"),
                                );
                              }

                              return DataTableWidget(users: users);
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

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
