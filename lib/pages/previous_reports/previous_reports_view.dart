import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/previous_reports/previous_reports_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
import '../../widgets/reports_card.dart';
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
              FutureBuilder(
                future: viewModel.addMissingRef
                    .where("userId",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Column(
                              children: [
                                ReportsCards(
                                  dateOfMissing: snapshot
                                      .data!.docs[index]["dateOfMissing"]
                                      .toString(),
                                  nameOfMissing: snapshot
                                      .data!.docs[index]["nameOfMissing"]
                                      .toString(),
                                  dateOfBirthOfMissing: '',
                                  ageOfMissing: snapshot
                                      .data!.docs[index]["ageOfMissing"]
                                      .toString(),
                                  placeOfMissing: snapshot
                                      .data!.docs[index]["placesOfMissing"]
                                      .toString(),
                                  onTapEdit: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRouter.editMissingScreen,
                                      arguments: snapshot.data!.docs[index].id,
                                    );
                                  },
                                  onTapDelete: () {},
                                  snapshot.data!.docs[index].id,
                                )
                              ],
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
