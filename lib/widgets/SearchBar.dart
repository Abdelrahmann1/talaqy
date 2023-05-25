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
class SearchBar extends SearchDelegate{
  final String? hintText;
  @override
  String? get searchFieldLabel => hintText;
  List names=["شوقي","سامر","غامر","لبيب","حسن"];

  SearchBar({this.hintText});
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
    List filterName = names.where((element) => element.startsWith(query)).toList();
    if (query == ""){
      return         ListView.builder(
          itemCount: query ==""? names.length : filterName.length,
          itemBuilder: (context , i){
            return InkWell(
              onTap: (){
                query= names[i] as String;
                showResults(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child:query==""? Text("${names[i]}",style: const TextStyle(fontSize: 14,color: AppColors.greyForFileds))
                    :
                Text("${filterName[i]}",style: const TextStyle(fontSize: 12,color: AppColors.greyForFileds),),
              ),
            );
          }
      );

    }

    return Column(
      children: [
        FutureBuilder(
          future:searchBarProvider.addMissingRef.get(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.docs.isNotEmpty)
              {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(snapshot.data!.docs[index]["nameOfMissing"]
                        .toString().toLowerCase().contains(query.toLowerCase()) ||
                        snapshot.data!.docs[index]["fatherName"]
                            .toString().toLowerCase().contains(query.toLowerCase())){
                      return InkWell(
                        onTap: () {
                          names.add(query);
                       showResults(context);
                        },
                        child: Text("${snapshot.data!.docs[index]["nameOfMissing"]} missing",style: TextStyle(color: Colors.black ,fontSize: 25),)
                      );
                    }

                  },
                );

              }
            }
            return Text('');
          },
        ),
        FutureBuilder(
          future:searchBarProvider.addFoundedRef.get(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.docs.isNotEmpty)
              {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(snapshot.data!.docs[index]["nameOfChild"]
                        .toString().toLowerCase().contains(query.toLowerCase())){
                      return InkWell(
                          onTap: () {
                            names.add(query);
                            showResults(context);
                          },
                          child: Text("${snapshot.data!.docs[index]["nameOfChild"]} founded",style: TextStyle(color: Colors.black,fontSize: 25),)
                      );
                    }
                  },
                );

            }
              }
            return Text('');

          }
          )

    ]
    );
       }
  @override
  Widget buildResults(BuildContext context) {
    if (query != "" && query != " " && query != null){
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
                                          imageUrl: snapshot
                                              .data!.docs[index]["imageUrl"]
                                              .toString(),
                                          dateOfMissing: snapshot.data!
                                              .docs[index]["dateOfMissing"]
                                              .toString(),
                                        ),
                                      )),
                                ),
                              ),
                            );
                          }else{
                            return const NotFound(
                              status: 'لا توجد بلاغات ',
                              imageassets: 'assets/images/notfound.png',
                            );
                          }

                        },
                      ),
                    );
                  } else {
                    return const NotFound(
                      status: 'لا توجد بلاغات ',
                      imageassets: 'assets/images/notfound.png',
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
                              imageassets: 'assets/images/notfound.png',
                            );
                          }

                        },
                      ),
                    );
                  }else{
                    return const NotFound(
                      status: 'لا توجد بلاغات ',
                      imageassets: 'assets/images/notfound.png',
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

