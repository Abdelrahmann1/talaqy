import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/home/home_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/main_button.dart';
import '../../utils/app_router.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const HomeView(),
      viewModel: HomeViewModel(),
    );
  }
}

class HomeView extends HookView<HomeViewModel> {

  const HomeView({Key? key, reactive = true});

  @override

  Widget render(context, viewModel) {
    double _w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return Container(
                      height: 200.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                iconSize: 30,
                                color: Colors.black,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.backspace_outlined,
                                ),
                              ),
                              MainButton(
                                "الإبلاغ عن مفقود",
                                () {
                                  Navigator.pushNamed(context, AppRouter.addMissingScreen);
                                },
                                bgColor: AppColors.primaryColor,
                              ),
                              MainButton(
                                "الإبلاغ عن موجود",
                                () {
                                  Navigator.pushNamed(context, AppRouter.addFoundedScreen);

                                },
                                bgColor: AppColors.primaryColor,
                              ),
                            ],
                          )),
                    );
                  });
            },
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            unselectedItemColor: AppColors.blackColor,
            selectedItemColor: AppColors.primaryColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedFontSize: 15,
            showUnselectedLabels: false,
            onTap: (index) {
              viewModel.onPageChanged(index);
            },
            iconSize: 30,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الرئيسية',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                icon: Icon(Icons.dehaze_rounded),
                label: 'بلاغاتي',
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          body:viewModel.screens.elementAt(viewModel.currentIndex)
        ),
      ),
    );
  }
}
