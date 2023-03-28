import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/home/home_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';

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
    return
      DefaultTabController(
        length: 2,
        child: SafeArea(
        child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: const TabBar(tabs: [
              Tab(text: "مفقود",),
              Tab(text: "موجود",),
            ],),
            leading:
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:  AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill
                  ),
                ),
              ),
            ),          actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            centerTitle: true,
            title: Text(
              'الصفحة الرئيسية',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {},
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            selectedItemColor: AppColors.primaryColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedFontSize: 15,
            showUnselectedLabels: false,
            onTap: (index){viewModel.onPageChanged(index);},
            iconSize: 30,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          body: TabBarView(
            children: [
              Center(child: Text("1",style: TextStyle(color: Colors.red),),),
              Center(child: Text("2",style: TextStyle(color: Colors.red),),),
              Center(child: Text("2",style: TextStyle(color: Colors.red),),),
            ],
          ),
        ),
    ),
      );
  }
}
