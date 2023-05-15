import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/people_status/add_founded/add_founded_people_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/main_button.dart';
import '../../../widgets/missed_form_field.dart';
class AddFoundedPeopleScreen extends StatelessWidget {
  const AddFoundedPeopleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const AddFoundedPeopleView(),
      viewModel: AddFoundedPeopleViewModel(),);}
}
class AddFoundedPeopleView extends HookView<AddFoundedPeopleViewModel> {
  const AddFoundedPeopleView({Key? key, reactive = true});
  @override
  Widget render(context, viewModel) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          centerTitle: true,
          title: Text(
            'الإبلاغ عن طفل مفقود',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        body: Form(
          key: viewModel.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 3,),
                MainFormField(
                  controller: viewModel.nameOfChild,
                  textInputType: TextInputType.text,

                  labelText:'إسم الطفل',
                  validator: (value) {
                    if (value!.length > 100) {
                      return "لا يمكن ان يكون اكثر من 100 حرف";
                    }
                    if (value.length < 2) {
                      return "لا يمكن ان يكون اقل من 3 حرف";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                MainFormField(
                  textInputType: TextInputType.number,
                  controller: viewModel.ageOfChild,
                  labelText:'عمر الطفل',
                  validator:
                      (value) {
                    if (value!.length > 3) {
                      return "لا يمكن ان يكون اكثر من 3 ارقام";
                    }
                    if (value.length < 0) {
                      return "لا يمكن ان يكون اقل من 3 حرف";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                MainFormField(
                  textInputType: TextInputType.text,
                  controller: viewModel.clothesOfChild,
                  labelText: 'الملابس الخاصة بالطفل *',
                  validator: (value) {
                    if (value!.length > 100) {
                      return "لا يمكن ان يكون اسم الاب اكير من 100 حروف";
                    }
                    if (value.length < 3) {
                      return "لا يمكن ان يكون اسم الاب اقل من 3 حروف";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                MainFormField(
                  textInputType: TextInputType.text,

                  controller: viewModel.placesOfChild,
                  labelText:'مكان العثور علي الطفل',
                  validator:
                      (value) {
                    if (value!.length > 100) {
                      return "لا يمكن ان يكون اكثر من 100 حرف";
                    }
                    if (value.length < 3) {
                      return "لا يمكن ان يكون اقل من 3 حرف";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                MainFormField(
                  textInputType: TextInputType.number,
                  controller: viewModel.phoneNumberOfReported,
                  labelText: 'رقم تليفون المبلغ ',
                  validator: (value) {
                    if (value!.length > 14) {
                      return "لا يمكن ان يكون اكثر من 14 حرف";
                    }
                    if (value.length < 0) {
                      return "لا يمكن ان يكون اقل من 0 حرف";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(": الجنس",
                        style: TextStyle(color: AppColors.fontSmoothGrey)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "ذكر",
                      style: TextStyle(color: AppColors.blackColor),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "أنثي",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "أنثي",
                        groupValue: viewModel.gender,
                        onChanged: (value) {
                          viewModel.setGender(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(" : لون البشرة",
                        style: TextStyle(color: AppColors.fontSmoothGrey)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "أسمر",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "أسمر",
                        groupValue: viewModel.skinColor,
                        onChanged: (value) {
                          viewModel.setSkinColor(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "خمري",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "خمري",
                        groupValue: viewModel.skinColor,
                        onChanged: (value) {
                          viewModel.setSkinColor(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "أبيض",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "أبيض",
                        groupValue: viewModel.skinColor,
                        onChanged: (value) {
                          viewModel.setSkinColor(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(" : لون العين",
                        style: TextStyle(color: AppColors.fontSmoothGrey)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "عسلي",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "عسلي",
                        groupValue: viewModel.colorOfEye,
                        onChanged: (value) {
                          viewModel.setColorOfEye(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "خضراء",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "خضراء",
                        groupValue: viewModel.colorOfEye,
                        onChanged: (value) {
                          viewModel.setColorOfEye(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "زرقاء",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "زرقاء",
                        groupValue: viewModel.colorOfEye,
                        onChanged: (value) {
                          viewModel.setColorOfEye(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "سوداء",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "سوداء",
                        groupValue: viewModel.colorOfEye,
                        onChanged: (value) {
                          viewModel.setColorOfEye(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(": لون الشعر",
                        style: TextStyle(color: AppColors.fontSmoothGrey)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "أسود",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "أسود",
                        groupValue: viewModel.hairColor,
                        onChanged: (value) {
                          viewModel.setHairColor(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "أشقر",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "أشقر",
                        groupValue: viewModel.hairColor,
                        onChanged: (value) {
                          viewModel.setHairColor(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "بني",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "بني",
                        groupValue: viewModel.hairColor,
                        onChanged: (value) {
                          viewModel.setHairColor(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("هل الطفل من ذوي الاحتياجات الخاصة ؟",
                        style: TextStyle(color: AppColors.fontSmoothGrey)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "نعم",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "نعم",
                        groupValue: viewModel.specialNeeds,
                        onChanged: (value) {
                          viewModel.setSpecialNeeds(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "لا",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "لا",
                        groupValue: viewModel.specialNeeds,
                        onChanged: (value) {
                          viewModel.setSpecialNeeds(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("هل يستطيع الطفل اخبار اسمه ؟",
                        style: TextStyle(
                          color: AppColors.fontSmoothGrey,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "نعم",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "نعم",
                        groupValue: viewModel.canTalkHisName,
                        onChanged: (value) {
                          viewModel.setCanTalk(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "لا",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    Radio(
                        value: "لا",
                        groupValue: viewModel.canTalkHisName,
                        onChanged: (value) {
                          viewModel.setCanTalk(value);
                        }),
                  ],
                ),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: viewModel.moreDetails,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "كتابة ملحوظة",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: AppColors.fontSmoothGrey,
                              width: 2.0,
                            ),
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MainButton(
                      "الإبلاغ عن العثور علي طفل", bgColor: AppColors.blackColor, () async {
                     viewModel.addFounded();


                  }),
                )
              ],
            ).setPageHorizontalPadding(context),
          ),
        )
    );
  }
}
