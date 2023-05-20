import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/all_missing_and_founded_Screen/all_missing_and_founded_view_model.dart';
import 'package:talaqy/pages/home/home_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/founded_people.dart';
import 'package:talaqy/widgets/main_button.dart';
import 'package:talaqy/widgets/missing_container.dart';
import '../../utils/app_router.dart';
import '../child_profile/founded_child_profile/founded_child_profile_view.dart';
import '../child_profile/missing_child_profile/missing_child_profile_view.dart';
class AllMissingAndFoundedScreen extends StatelessWidget {
  const AllMissingAndFoundedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const AllMissingAndFoundedView(),
      viewModel: AllMissingAndFoundedViewModel(),
    );
  }
}

class AllMissingAndFoundedView extends HookView<AllMissingAndFoundedViewModel> {
  const AllMissingAndFoundedView({Key? key, reactive = true});
  @override

  Widget render(context, viewModel) {
    double _w = MediaQuery.of(context).size.width;
    return DefaultTabController(
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
            leading: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AppRouter.userProfileScreen);
              },
              child: Padding(
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
            ),
            actions: [
            ],
            centerTitle: true,
            title: Text(
              'الصفحة الرئيسية',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          backgroundColor: AppColors.white,
          body: TabBarView(
            children: [
              viewModel.data==null?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      children:[
                        const Text(
                          'لا توجد بلاغات ',
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.blackColor,
                          ),
                        ),SizedBox(height: 20,),
                        Image.asset(
                          'assets/images/notfound.png',
                          width: 300,
                        )])
                ],
              ):
              FutureBuilder(
                future: viewModel.addMissingRef.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (snapshot.hasData) {
                    return AnimationLimiter(
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
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                              return MissingChildProfileScreen(
                                                docid: snapshot.data!.docs[index].id,
                                                list: snapshot.data!.docs[index],
                                              );
                                            }));
                                      },

                                      child: MissingContainer(
                                        onTap: () {},
                                        borderColor: Colors.blue,
                                        ageOfMissing: snapshot
                                            .data!.docs[index]["ageOfMissing"]
                                            .toString(),
                                        nameOfMissing: snapshot
                                            .data!.docs[index]["nameOfMissing"]
                                            .toString(),
                                        placesOfMissing: snapshot
                                            .data!.docs[index]["placesOfMissing"]
                                            .toString(),
                                        docId: snapshot.data!.docs[index].id,
                                        list: snapshot.data!.docs[index],
                                        imageUrl:  snapshot
                                            .data!.docs[index]["imageUrl"]
                                            .toString(),
                                        dateOfMissing:snapshot
                                            .data!.docs[index]["dateOfMissing"]
                                            .toString() ,
                                      ),
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
              FutureBuilder(
                future: viewModel.addFoundedRef.get(),
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
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) {
                                                return FoundedChildProfileScreen(
                                                  docid: snapshot.data!.docs[index].id,
                                                  list: snapshot.data!.docs[index],
                                                );
                                              }));
                                        },
                                        child: FoundedPeopleContainer(
                                          onTap: () {},
                                          borderColor: Colors.blue,
                                          price: "",
                                          dateTime: "",
                                          bookingDate: "",
                                          nameOfFounded: snapshot.data!.docs[index]["nameOfChild"],
                                          dateOfReported: snapshot.data!.docs[index]["nameOfChild"],
                                          placesOfChild:snapshot.data!.docs[index]["placesOfChild"],
                                          ageOfChild: snapshot.data!.docs[index]["ageOfChild"],
                                          docId: snapshot.data!.docs[index].id,
                                          list: snapshot.data!.docs[index],
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                  }
                  if(snapshot.data!.docs.isEmpty){
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            children:[
                              const Text(
                                'لا توجد بلاغات ',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppColors.blackColor,
                                ),
                              ),SizedBox(height: 20,),
                              Image.asset(
                                'assets/images/notfound.png',
                                width: 300,
                              )])
                      ],
                    );

                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
