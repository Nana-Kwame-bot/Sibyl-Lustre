import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  int _currentPage = 0;
  String pageTitle = 'Report';

  // Widget getBottomAppbarWidget() {
  //   return PreferredSize(
  //     child: Text(
  //       _currentPage == 0 ?  'All Sky Surface Shortwave Downward Irradia nce' : _currentPage == 1 ?
  //     ),
  //     preferredSize: AppBar().preferredSize,
  //   );
  // }

  void getTitle({required int currentIndex}) {
    switch (currentIndex) {
      case 0:
        pageTitle = 'Report';
        break;
      case 1:
        pageTitle = 'Statistics';
        break;
      default:
        pageTitle = '';
        break;
    }
  }

  int get currentPage => _currentPage;

  void changePage(int index) {
    _currentPage = index;
    getTitle(currentIndex: index);
    notifyListeners();
  }
}
