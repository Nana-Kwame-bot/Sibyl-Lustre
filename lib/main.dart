import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sibly_lustre/screens/report_screen.dart';
import 'package:sibly_lustre/screens/stats_screen.dart';
import 'package:sibly_lustre/utils/intensityData.dart';
import 'package:sibly_lustre/utils/page_notifier.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return PageNotifier();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return IntensityData();
            },
          ),
        ],
        child: const SunShineApp(),
      ),
    );

class SunShineApp extends StatelessWidget {
  const SunShineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sibyl Lustre',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Provider.of<PageNotifier>(context).pageTitle),
      ),
      bottomNavigationBar: Consumer<PageNotifier>(
        builder: (BuildContext context, pageNotifier, Widget? child) {
          return CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: Colors.blue,
            items: <Widget>[
              Icon(Icons.list, size: 30),
              Icon(Icons.stacked_bar_chart, size: 30),
            ],
            onTap: (index) {
              index == pageNotifier.currentPage
                  ? print('same screen')
                  : _pageController.jumpToPage(
                      index,
                    );
              pageNotifier.changePage(index);
              //Handle button tap
            },
            index: pageNotifier.currentPage,
          );
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          Provider.of<PageNotifier>(context, listen: false).changePage(index);
        },
        controller: _pageController,
        children: [
          ReportScreen(),
          StatsScreen(),
          // LocationScreen(),
        ],
      ),
    );
  }
}
