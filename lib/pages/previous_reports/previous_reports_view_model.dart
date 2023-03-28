import 'package:pmvvm/pmvvm.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class PreviousReportsViewModel extends ViewModel {
  int page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  onPageIndex(int index){
    page=index;
    notifyListeners();
  }
}
