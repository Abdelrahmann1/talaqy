import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/child_profile/missing_child_profile/missing_child_profile_view_model.dart';
import '../../../models/onboarding_model.dart';
import '../../../utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
class MissingChildProfileScreen extends StatelessWidget {
  dynamic docid;
  dynamic list;
  MissingChildProfileScreen({Key? key, this.docid, this.list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const MissingChildProfileView(),
      viewModel: MissingChildProfileViewModel(docId: docid, list: list),
    );
  }
}

class MissingChildProfileView extends HookView<MissingChildProfileViewModel> {
  const MissingChildProfileView({Key? key, reactive = true});
  @override
  Widget render(context, viewModel) {
    return SafeArea(
      child: Scaffold(

          body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Stack(
                children: [
                  SizedBox(
                    child: CarouselSlider(
                     items :[
                       SizedBox(
                         child: CachedNetworkImage(
                             imageUrl: viewModel.list['imageUrl'],
                             placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
                             errorWidget: (context, url, error) =>  const Icon(Icons.error_outline),
                             fit: BoxFit.fill
                         ),
                       ),
                       SizedBox(

                         child: CachedNetworkImage(
                             imageUrl: viewModel.list['imageUrl2'],
                             placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
                             errorWidget: (context, url, error) =>  const Icon(Icons.error_outline),
                             fit: BoxFit.fill
                         ),
                       ),
                       SizedBox(

                         child: CachedNetworkImage(
                             imageUrl: viewModel.list['imageUrl3'],
                             placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
                             errorWidget: (context, url, error) =>  const Icon(Icons.error_outline),
                             fit: BoxFit.fill
                         ),
                       ),
                     ],
                      carouselController: viewModel.buttonCarouselController,
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        scrollPhysics: const BouncingScrollPhysics(),
                        height: double.infinity,
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged:(val,reason){
                          viewModel.onPageChanged(val);
                        }
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundGrey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: AppColors.blackColor,
                              ),
                              onPressed: () async {
                                viewModel.shareData();

                              }),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundGrey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.blackColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 280),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                              onBoardingList.length,
                                  (index) => AnimatedContainer(
                                margin: const EdgeInsets.only(right: 7),
                                duration: const Duration(milliseconds: 900),
                                width: viewModel.currentIndex==index?30:13,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: AppColors.backgroundGrey,
                                    borderRadius: BorderRadius.circular(20)),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        viewModel.list["dateOfSend"],
                        style: const TextStyle(
                          color: AppColors.fontSmoothGrey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Text(" : تاريخ الاعلان", style: TextStyle(
                      color: AppColors.fontSmoothGrey,
                      fontSize: 10,)),

                  ],
                ),
                Text(
                  viewModel.list['nameOfMissing'],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Text(" عام", style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 10,)),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              viewModel.list['ageOfMissing'],
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["placesOfMissing"],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["dateOfMissing"],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["skinColor"],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["colorOfEye"],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["hairColor"],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": السن - ",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": مكان فقد الطفل -",
                          style: TextStyle(
                            color: AppColors.greyForFileds,
                            fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "  : تاريخ فقد الطفل -",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": البشرة - ",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ":لون العين - ",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ":لون الشعر -",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0, left: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        ": ملاحظات عن الطفل",
                        style: TextStyle(
                            color: AppColors.greyForFileds,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        viewModel.list["MoreDetails"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 28.0, top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () async {
                      launch(viewModel.fatherPhoneNumber.toString());
                      await FlutterPhoneDirectCaller.callNumber(
                          viewModel.fatherPhoneNumber.toString());
                    },
                    child: Text(
                      ("الاتصال بوالد الطفل"),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              )),
        ],
      ).setPageHorizontalPadding(context)
      ),
    );
  }
}
