import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/user_profile/user_profile_view_model.dart';
import '../../provider/auth_provider.dart';
import '../../utils/app_colors.dart';
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const UserProfileView(),
      viewModel: UserProfileViewModel(),
    );
  }
}

class UserProfileView extends HookView<UserProfileViewModel> {
  const UserProfileView({Key? key, reactive = true});
  @override
  Widget render(context, viewModel) {
    final userProviderAuth = Provider.of<UserProviderAuth>(context);    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: FutureBuilder(
          future: viewModel.userData.where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 150.0)),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 115.0, top: 70),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.white, width: 6)),
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                "assets/images/prof.jpg",
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 202.0, top: 175),
                      //     child: Container(
                      //       width: 50,
                      //       height: 50,
                      //       decoration: const BoxDecoration(
                      //         color: AppColors.circleAvatar,
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: IconButton(
                      //         icon: const Icon(
                      //           Icons.camera_alt_outlined,
                      //           color: AppColors.white,
                      //         ),
                      //         onPressed: () async{
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 300.0, top: 35),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: AppColors.circleAvatar,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_outlined,
                                color: AppColors.blackColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   Text(
                    snapshot.data!.docs[0]["userName"].toString()??'aa',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                   Text(
                    snapshot.data!.docs[0]["email"].toString()??"ss",
                    style: const TextStyle(color: AppColors.greyForFileds),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 327,
                      height: 192,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child:
                      ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.greyForFileds,
                                ),
                                onPressed: () {},
                              ),
                              const Text(
                                "الإعدادات العامة  ",
                                style: TextStyle(color: AppColors.blackColor),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.settings_suggest_outlined,
                                  color: AppColors.greyForFileds,
                                  size: 35,
                                ),
                                onPressed: () {
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.greyForFileds,
                                ),
                                onPressed: () {},
                              ),
                              const Text(
                                "السياسات والاحكام",
                                style: TextStyle(color: AppColors.blackColor),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.safety_check_outlined,
                                  color: AppColors.greyForFileds,
                                  size: 35,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.greyForFileds,
                                ),
                                onPressed: () {
                                  userProviderAuth.signOut(context);
                                },
                              ),
                              const Text(
                                "تسجيل الخروج    ",
                                style: TextStyle(color: AppColors.blackColor),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.exit_to_app,
                                  color: AppColors.greyForFileds,
                                  size: 35,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "نسخه إصدار رقم  1.0 ",
                          style: TextStyle(color: AppColors.greyForFileds),
                        ),

                        Text("من شركه اكسيم",
                          style: TextStyle(color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    ));
  }
}
