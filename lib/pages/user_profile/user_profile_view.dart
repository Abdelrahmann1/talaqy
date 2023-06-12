import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talaqy/pages/user_profile/user_profile_view_model.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/utils/privacy_and_policy.dart';
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
              return SingleChildScrollView(
                child: Column(
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
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    snapshot.data!.docs[0]["name"] != null
                        ? Text(
                            snapshot.data!.docs[0]["name"].toString().split("@")[0],
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
                                InkWell(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return  AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  20.0,
                                                ),
                                              ),
                                            ),
                                            contentPadding: const EdgeInsets.only(
                                              top: 10.0,
                                            ),

                                            actions: [
                                              IconButton(
                                                icon: const Icon(Icons.close,color: Colors.black,),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],

                                            title: const Text(
                                              "السياسات والاحكام",

                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0,decoration: TextDecoration.underline,decorationThickness: 2.0),
                                            ),
                                            content:  SizedBox(
                                              height: 400,
                                              child: SingleChildScrollView(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Expanded(
                                                        child: Column(
                                                          children: [

                                                            Text(PrivacyPolicyText.getPrivacyText(),
                                                              textAlign: TextAlign.right,
                                                              style: const TextStyle(fontSize: 12,color: AppColors.blackColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text(
                                    "السياسات والاحكام",
                                    style: TextStyle(color: AppColors.blackColor),
                                  ),
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
                            InkWell(
                              onTap: ()async{
                                Navigator.pushNamed(context, AppRouter.forgetPasswordScreen);},
                              child: Row(
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
                                    "تغير كلمه السر ",
                                    style: TextStyle(color: AppColors.blackColor),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.password_outlined,
                                      color: AppColors.greyForFileds,
                                      size: 35,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: ()async{
                                await FirebaseAuth.instance.signOut();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.remove('uidToken');
                               Navigator.pushNamedAndRemoveUntil(context, AppRouter.loginScreen,(Route<dynamic> route) => false);

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.greyForFileds,
                                    ),
                                    onPressed: () async{},
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
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    ));
  }
}
