import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/child_profile/founded_child_profile/founded_child_profile_view.dart';
import 'package:talaqy/provider/search_bar%20provider.dart';
import 'package:talaqy/widgets/missing_container.dart';
import '../pages/child_profile/missing_child_profile/missing_child_profile_view.dart';
import '../utils/app_colors.dart';
import 'founded_people.dart';
import 'not_found.dart';
class CustomSearchBar extends SearchDelegate{
  final String? hintText;
  @override
  String? get searchFieldLabel => hintText;
  List names=["شوقي","سامر","غامر","لبيب","حسن"];
  CustomSearchBar({this.hintText});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query="";
      }, icon: const Icon(Icons.close)),
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context,null);
    }, icon: const Icon(Icons.arrow_back));

  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBarProvider = Provider.of<SearchBarProvider>(context);
    if (query == "" || query == " " || query == "  "){
      return Padding(
        padding: const EdgeInsets.only(right:12.0,top: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
              itemCount:names.length,
              itemBuilder: (context , i){
                return InkWell(
                  onTap: (){
                    query= names[i] as String;
                    showResults(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text("${names[i]}",style: const TextStyle(fontSize: 20,color: AppColors.greyForFileds))
                  ),
                );
              }
          ),
        ),
      );

    }
    else{
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Text(""),
            leadingWidth: 1,
            title: const TabBar(
              tabs: [
                Tab(
                  text: "مفقود",
                ),
                Tab(
                  text: "موجود",
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(right:12.0,top: 10),
              child: TabBarView(
                children: [
                    FutureBuilder(
                      future:searchBarProvider.addMissingRef.get(),
                      builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int i) {
                              if (snapshot.data!.docs[i]["fatherName"]
                                  .toString().toLowerCase().contains(query.toLowerCase())||
                                  snapshot.data!.docs[i]["nameOfMissing"]
                                      .toString().toLowerCase().contains(query.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    query = "${snapshot.data!
                                        .docs[i]["nameOfMissing"]} ${snapshot.data!
                                        .docs[i]["fatherName"]
                                        .toString().toLowerCase()}";
                                    names.add(query);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) {
                                              return MissingChildProfileScreen(
                                                docid: snapshot
                                                    .data!.docs[i].id,
                                                list:
                                                snapshot.data!.docs[i],
                                              );
                                            }));
                                  },
                                  child: Text(
                                      "${snapshot.data!.docs[i]["nameOfMissing"]} ${snapshot.data!.docs[i]["fatherName"]}",
                                      style: const TextStyle(fontSize: 20,
                                          color: AppColors.greyForFileds)),
                                );
                              }
                            },
                          );
                        }
                      }
                      return const Text('');
                      },
                    ),
                    FutureBuilder(
              future:searchBarProvider.addFoundedRef.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int i) {
                        if(snapshot.data!.docs[i]["nameOfChild"]
                            .toString().toLowerCase().contains(query.toLowerCase())){
                          return InkWell(
                            onTap: () {
                              query = "${snapshot.data!.docs[i]["nameOfChild"]}";
                              names.add(query);
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return FoundedChildProfileScreen(
                                          docid: snapshot
                                              .data!.docs[i].id,
                                          list:
                                          snapshot.data!.docs[i],
                                        );
                                      }));
                            },
                            child: Text(snapshot.data!.docs[i]["nameOfChild"].toString(),style: const TextStyle(fontSize: 20,color: AppColors.greyForFileds)),
                          );
                        }

                      },
                    );
                  }
                }
                return const Text('');
              },
        )
                ],
              ),
            ),
          ),
        ),
      );

    }
  }
  @override
  Widget buildResults(BuildContext context) {
    if (query != "" && query != " "){
      if (!names.contains(query) ) {
        names.add(query);
      }
    }
    final searchBarProvider = Provider.of<SearchBarProvider>(context);
    var _w = MediaQuery.of(context).size.width;
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Text(""),
          leadingWidth: 1,
          title: const TabBar(
            tabs: [
              Tab(
                text: "مفقود",
              ),
              Tab(
                text: "موجود",
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.white,
        body: TabBarView(
          children: [
            FutureBuilder(
              future:searchBarProvider.addMissingRef.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.docs.isNotEmpty)
                    {
                    return AnimationLimiter(
                      child: ListView.builder(
                        padding: EdgeInsets.all(_w / 25),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          if(snapshot.data!.docs[index]["nameOfMissing"]
                              .toString().toLowerCase().contains(query.toLowerCase()) ||
                              snapshot.data!.docs[index]["fatherName"]
                              .toString().toLowerCase().contains(query.toLowerCase())){
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration:
                                  const Duration(milliseconds: 2500),
                                  child: Container(
                                      margin:
                                      EdgeInsets.only(bottom: _w / 20),
                                      height: _w / 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.1),
                                            blurRadius: 40,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return MissingChildProfileScreen(
                                                      docid: snapshot
                                                          .data!.docs[index].id,
                                                      list:
                                                      snapshot.data!.docs[index],
                                                    );
                                                  }));
                                        },
                                        child: MissingContainer(
                                          onTap: () {},
                                          borderColor: Colors.blue,
                                          ageOfMissing: snapshot.data!
                                              .docs[index]["ageOfMissing"]
                                              .toString(),
                                          nameOfMissing: snapshot.data!
                                              .docs[index]["nameOfMissing"]
                                              .toString(),
                                          placesOfMissing: snapshot.data!
                                              .docs[index]["placesOfMissing"]
                                              .toString(),
                                          docId:
                                          snapshot.data!.docs[index].id,
                                          list: snapshot.data!.docs[index],
                                          imageUrl: snapshot.data!.docs[index]["imageUrl"].toString(),
                                          dateOfMissing: snapshot.data!
                                              .docs[index]["dateOfMissing"]
                                              .toString(),
                                          locationOfCity: snapshot.data!.docs[index]["CityOfMissing"].toString(),
                                          locationOfSection: snapshot.data!.docs[index]["SecitonOfMissing"].toString(),
                                        ),
                                      )),
                                ),
                              ),
                            );
                          }else{
                            return const NotFound(
                              status: 'لا توجد بلاغات ',
                              imageAssets: 'assets/images/notfound.png',
                            );
                          }

                        },
                      ),
                    );
                  } else {
                    return const NotFound(
                      status: 'لا توجد بلاغات ',
                      imageAssets: 'assets/images/notfound.png',
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            FutureBuilder(
              future: searchBarProvider.addFoundedRef.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return AnimationLimiter(
                      child: ListView.builder(
                        padding: EdgeInsets.all(_w / 25),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          if(snapshot.data!.docs[index]["nameOfChild"]
                              .toString().toLowerCase().contains(query.toLowerCase())){
                            return AnimationConfiguration.staggeredList(
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
                                                            borderRadius: const BorderRadius.all(
                                                                Radius.circular(10)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                Colors.black.withOpacity(0.1),
                                                                blurRadius: 40,
                                                                spreadRadius: 10,
                                                              ),
                                                            ],
                                                          ),
                                                          child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(context).push(
                                                                    MaterialPageRoute(
                                                                        builder: (context) {
                                                                          return FoundedChildProfileScreen(
                                                                            docid: snapshot
                                                                                .data!.docs[index].id,
                                                                            list:
                                                                            snapshot.data!.docs[index],
                                                                          );
                                                                        }));
                                                              },
                                                              child: FoundedPeopleContainer(
                                                                borderColor: Colors.blue,
                                                                docId:
                                                                snapshot.data!.docs[index].id,
                                                                list: snapshot.data!.docs[index],
                                                                placesOfChild: snapshot.data!
                                                                    .docs[index]["placesOfChild"]
                                                                    .toString(),
                                                                nameOfFounded: snapshot.data!
                                                                    .docs[index]["nameOfChild"]
                                                                    .toString(),
                                                                dateOfReported: snapshot
                                                                    .data!.docs[index]["dateOfSend"]
                                                                    .toString(),
                                                                ageOfChild: snapshot
                                                                    .data!.docs[index]["ageOfChild"]
                                                                    .toString(),
                                                                imageUrl: snapshot
                                                                    .data!.docs[index]["imageUrl"]
                                                                    .toString(),
                                                                locationOfSection: snapshot
                                                                    .data!.docs[index]["sectionOfFounded"]
                                                                    .toString(),
                                                                locationOfCity:snapshot
                                                                    .data!.docs[index]["CityOfFounded"]
                                                                  .toString(),
                                                              )
                                                            // FoundedPeopleContainer(
                                                            //   onTap: () {},
                                                            //   borderColor: Colors.blue,
                                                            //   nameOfFounded: snapshot.data!.docs[index]["nameOfChild"],
                                                            //   dateOfReported: snapshot.data!.docs[index]["nameOfChild"],
                                                            //   placesOfChild:snapshot.data!.docs[index]["placesOfChild"],
                                                            //   ageOfChild: snapshot.data!.docs[index]["ageOfChild"],
                                                            //   docId: snapshot.data!.docs[index].id,
                                                            //   list: snapshot.data!.docs[index],
                                                            //   imageUrl: snapshot.data!.docs[index]["imageUrl"],
                                                            // ),
                                                          )),
                                                    ),
                                                  ),
                                                );
                          }
                          else{
                            return const NotFound(
                              status: 'لا توجد بلاغات ',
                              imageAssets: 'assets/images/notfound.png',
                            );
                          }

                        },
                      ),
                    );
                  }else{
                    return const NotFound(
                      status: 'لا توجد بلاغات ',
                      imageAssets: 'assets/images/notfound.png',
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }

}
