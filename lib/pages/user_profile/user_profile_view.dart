import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/user_profile/user_profile_view_model.dart';
import 'package:talaqy/utils/app_router.dart';
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
    final userProviderAuth = Provider.of<UserProviderAuth>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: FutureBuilder(
          future: viewModel.userData.where("userId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
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
                            child: ClipOval(
                              child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[0]["imageUrl"],
                                  width: 90,
                                  height: 90,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/prof.jpg"),
                                  fit: BoxFit.fill),
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
                  snapshot.data!.docs[0]["name"] != null
                      ? Text(
                          snapshot.data!.docs[0]["name"].toString(),
                          style: const TextStyle(color: Colors.black),
                        )
                      : const Text("No Name"),
                  const SizedBox(
                    height: 3,
                  ),
                  snapshot.data!.docs[0]["email"] != null
                      ? Text(
                          snapshot.data!.docs[0]["email"].toString(),
                          style:
                              const TextStyle(color: AppColors.greyForFileds),
                        )
                      : const Text("no email "),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 327,
                      height: 192,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: ListView(
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
                                onPressed: () async{
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacementNamed(context, AppRouter.loginScreen);

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
                  const Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "نسخه إصدار رقم  1.0 ",
                          style: TextStyle(color: AppColors.greyForFileds),
                        ),
                        Text(
                          "من شركه اكسيم",
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
