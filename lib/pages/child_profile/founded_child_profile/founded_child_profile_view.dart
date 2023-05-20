import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'founded_child_profile_view_model.dart';

class FoundedChildProfileScreen extends StatelessWidget {
  var docid;
  var list;
  FoundedChildProfileScreen({Key? key, this.docid, this.list}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const FoundedChildProfileView(),
      viewModel: FoundedChildProfileViewModel(docId: docid, list: list),
    );
  }
}

class FoundedChildProfileView extends HookView<FoundedChildProfileViewModel> {
  const FoundedChildProfileView({Key? key, reactive = true});
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
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/person.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 300.0, top: 25),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.greyForFileds,
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
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 25),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.greyForFileds,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: const Icon(
                              Icons.share,
                              color: AppColors.blackColor,
                            ),
                            onPressed: () async {
                              Share.share(
                                  'check out my website https://example.com');
                            }),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "14/5/2023",
                    style: TextStyle(
                      color: AppColors.fontSmoothGrey,
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  viewModel.list['nameOfChild'],
                  style: TextStyle(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list['ageOfChild'],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["placesOfChild"],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.list["placesOfChild"],
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": السن ",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": مكان وجود الطفل ",
                          style: TextStyle(
                            color: AppColors.greyForFileds,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": تاريخ العثور علي الطفل",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ": البشرة ",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ":لون العين  ",
                          style: TextStyle(
                              color: AppColors.greyForFileds,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ":لون الشعر",
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
              Column(
                children: [
                  const Text(
                    ": ملاحظات عن الطفل",
                    style: TextStyle(
                        color: AppColors.greyForFileds,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      viewModel.list["moreDetails"],
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () async {
                      launch(viewModel.fatherPhoneNumber.toString());
                      await FlutterPhoneDirectCaller.callNumber(viewModel.fatherPhoneNumber.toString());
                    },
                    child: Text(
                      ("الاتصال "),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              )),
        ],
      )),
    );
  }
}
