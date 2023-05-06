import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/home/home_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/founded_people.dart';
import 'package:talaqy/widgets/main_button.dart';
import 'package:talaqy/widgets/missing_container.dart';
import '../../provider/auth_provider.dart';
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
    final userProviderAuth = Provider.of<UserProviderAuth>(context);

    double _w = MediaQuery.of(context).size.width;
    return
      DefaultTabController(
      length: 2,
      child:
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "مفقود",
                ),
                Tab(
                  text: "موجود",
                ),
              ],
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await userProviderAuth.signOut();
                  Navigator.pushReplacementNamed(
                      context, AppRouter.loginScreen);
                },
              ),
            ],
            centerTitle: true,
            title: Text(
              'الصفحة الرئيسية',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
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
                                () {},
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
                  label: 'Home',
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          body: TabBarView(
            children: [
              FutureBuilder(
                future: viewModel.addMissingRef.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (snapshot.hasData) {
                    return
                      AnimationLimiter(
                      child: ListView.builder(
                        padding: EdgeInsets.all(_w / 25),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              duration: const Duration(milliseconds: 2500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(milliseconds: 2500),
                                child:
                                Container(
                                    margin: EdgeInsets.only(bottom: _w / 20),
                                    height: _w / 3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 40,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: MissingContainer(
                                      onTap: () {},
                                      borderColor: Colors.blue,
                                      ticketType: "ss",
                                      price: "",
                                      dateTime: "",
                                      nameOfLine: "",
                                      arrivalPoint: "",
                                      bookingDate: "",
                                      NameOfMissing: snapshot
                                          .data!.docs[index]["nameOfMissing"]
                                          .toString(),
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(_w / 25),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(milliseconds: 2500),
                          child: Container(
                              margin: EdgeInsets.only(bottom: _w / 20),
                              height: _w / 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: FoundedPeopleContainer(
                                onTap: () {},
                                borderColor: Colors.blue,
                                invoicesNumber: "aa",
                                ticketType: "ss",
                                price: "",
                                dateTime: "",
                                nameOfLine: "",
                                arrivalPoint: "",
                                bookingDate: "",
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
