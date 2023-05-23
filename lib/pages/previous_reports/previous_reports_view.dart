import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/people_status/add_founded/edit_founded_view.dart';
import 'package:talaqy/pages/previous_reports/previous_reports_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/not_found.dart';
import 'package:talaqy/widgets/show_loading.dart';
import '../../widgets/reports_card.dart';
import '../people_status/add_missing/edit_missing_view.dart';

class PreviousReportsScreen extends StatelessWidget {
  const PreviousReportsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const PreviousReportsView(),
      viewModel: PreviousReportsViewModel(),
    );
  }
}

class PreviousReportsView extends HookView<PreviousReportsViewModel> {
  const PreviousReportsView({Key? key, reactive = true});

  @override
  Widget render(context, viewModel) {

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
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
            centerTitle: true,
            title: Text(
              'البلاغات السابقة',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          backgroundColor: AppColors.backgroundGrey,
          body: TabBarView(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  viewModel.refreshData();
                },
                child: FutureBuilder(
                    future: viewModel.addMissingRef
                        .where("userId",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {

                      if (snapshot.connectionState == ConnectionState.done) {
                        viewModel.data = snapshot.data!;

                        if (viewModel.data!.docs.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    children: [
                                      ReportsCards(
                                        dateOfMissing: snapshot
                                            .data!.docs[index]["dateOfMissing"]
                                            .toString(),
                                        nameOfMissing: snapshot
                                            .data!.docs[index]["nameOfMissing"]
                                            .toString(),
                                        ageOfMissing: snapshot
                                            .data!.docs[index]["ageOfMissing"]
                                            .toString(),
                                        placeOfMissing: snapshot.data!
                                            .docs[index]["placesOfMissing"]
                                            .toString(),
                                        onTapEdit: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return EditMissingScreen(
                                              docid:
                                                  snapshot.data!.docs[index].id,
                                              list: snapshot.data!.docs[index],
                                            );
                                          }));
                                        },
                                        onTapDelete: () async {
                                          AlertDialog(
                                            title: Text('Alert Dialog'),
                                            content: Text('This is an example of an alert dialog.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () async{
                                                  // await viewModel.addMissingRef.doc(snapshot.data!.docs[index].id).delete();
                                                  // await FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl"]).delete();
                                                  // await  FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl2"]).delete();
                                                  // await  FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl3"]).delete();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                        docId: snapshot.data!.docs[index].id,
                                        list: snapshot.data!.docs[index],
                                        statusOfChild: 'متغيب من',
                                        imageUrl: snapshot.data!.docs[index]
                                            ["imageUrl"],
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return const NotFound(
                            status: 'لا توجد بلاغات سابقة',
                            imageassets: 'assets/images/notfound.png',
                          );
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  viewModel.fetchData();
                },
                child: FutureBuilder(
                    future: viewModel.addFoundedRef
                        .where("userId",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    children: [
                                      ReportsCards(
                                        dateOfMissing: snapshot
                                            .data!.docs[index]["dateOfFounded"]
                                            .toString(),
                                        nameOfMissing: snapshot
                                            .data!.docs[index]["nameOfChild"]
                                            .toString(),
                                        ageOfMissing: snapshot
                                            .data!.docs[index]["ageOfChild"]
                                            .toString(),
                                        placeOfMissing: snapshot
                                            .data!.docs[index]["placesOfChild"]
                                            .toString(),
                                        onTapEdit: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return EditFoundedScreen(
                                              docid:
                                                  snapshot.data!.docs[index].id,
                                              list: snapshot.data!.docs[index],
                                            );
                                          }));
                                        },
                                        onTapDelete: ()  {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('من فضلك قم بتحديد أسباب إلغاء النشر',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 13),),
                                                content:Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "تم العثور علي الطفل من خلال التطبيق",
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(color: AppColors.blackColor,fontSize: 12),
                                                          ),
                                                        ),
                                                        Radio(
                                                            value: "ذكر",
                                                            groupValue: viewModel.gender,
                                                            onChanged: (value) {
                                                              viewModel.setGender(value);
                                                            }),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "تم العثور علي الطفل بطريقة أخري",
                                                            textAlign: TextAlign.start,

                                                            style: TextStyle(color: AppColors.blackColor,fontSize: 12),
                                                          ),
                                                        ),
                                                        Radio(
                                                            value: "أنثي",
                                                            groupValue: viewModel.gender,
                                                            onChanged: (value) {
                                                              viewModel.setGender(value);
                                                            }),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context); // Close the dialog
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );


                                          // await viewModel.addFoundedRef.doc(snapshot.data!.docs[index].id).delete();
                                          // await FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl"]).delete();
                                          // await  FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl2"]).delete();
                                          // await  FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl3"]).delete();
                                        },
                                        docId: snapshot.data!.docs[index].id,
                                        list: snapshot.data!.docs[index],
                                        statusOfChild: 'موجود',
                                        imageUrl: snapshot.data!.docs[index]
                                            ["imageUrl"],
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return const NotFound(
                            status: 'لا توجد بلاغات سابقة',
                            imageassets: 'assets/images/notfound.png',
                          );
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
