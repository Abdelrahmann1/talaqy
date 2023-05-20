import 'package:flutter/material.dart';
import 'package:pmvvm/view_model.dart';
import 'package:talaqy/models/onboarding_model.dart';

import '../../utils/app_router.dart';

class OnBoardingViewModel extends ViewModel{
  @override
  void init() {
    pageController = PageController();
    super.init();
  }
  String? title;
  String? subtitle;
  Image? image;
  int currentPage = 0;
  late PageController pageController;
  onPageChanged(int index){
    currentPage=index;
    notifyListeners();
  }
  nextPage(){
    currentPage ++;
    if(currentPage >onBoardingList.length-1 ){

      Navigator.pushNamed(context, AppRouter.registerScreen);
    }else{
      pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 900),
          curve:Curves.easeInOut);
      notifyListeners();

    }

  }
}