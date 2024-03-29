import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/people_status/add_founded/add_founded_people_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/main_button.dart';
import '../../../provider/alert_provider.dart';
import '../../../widgets/missed_form_field.dart';

class AddFoundedPeopleScreen extends StatelessWidget {
  const AddFoundedPeopleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const AddFoundedPeopleView(),
      viewModel: AddFoundedPeopleViewModel(),
    );
  }
}

class AddFoundedPeopleView extends HookView<AddFoundedPeopleViewModel> {
  const AddFoundedPeopleView({Key? key, reactive = true});


  @override
  Widget render(context, viewModel) {
    final alertExitApp = Provider.of<AlertExitApp>(context);

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
          leading: Container(),
          centerTitle: true,
          title: Text(
            'الإبلاغ عن موجود',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        body: Form(
          key: viewModel.formKey,
          child: WillPopScope(
            onWillPop: (){
              return alertExitApp.alertExitApp(context);

            },

            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  MainFormField(
                    controller: viewModel.nameOfChild,
                    textInputType: TextInputType.text,
                    labelText: 'إسم الموجود',
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
                    labelText: 'العمر الموجود',

                    validator: (value) {
                      if (value!.length > 3   || value.isEmpty) {
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
                    labelText: 'الملابس الخاصة بالموجود *',
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: AppColors.blackColor,
                          width: 1.0,
                        )),
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يجب اختار البلد';
                          }
                          return null;
                        },
                        value: viewModel.countryOfFounded,
                        style: Theme.of(context).textTheme.displaySmall,
                        hint: Text(
                          '   اختار البلد',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        onChanged: (value) {
                          viewModel.setCountryOfFounded(value);
                        },
                        items: viewModel.buildCountryDropdownItems(),
                        alignment: Alignment.center,

                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: AppColors.blackColor,
                          width: 1.0,
                        )),
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يجب اختار المحافظه';
                          }
                          return null;
                        },
                        value: viewModel.cityOfFounded,
                        style: Theme.of(context).textTheme.displaySmall,
                        hint: Text('   اختار المحافظه',
                            style: Theme.of(context).textTheme.displaySmall),
                        onChanged: (value) {
                          viewModel.setCityOfFounded(value);
                        },
                        alignment: Alignment.center,
                        items: viewModel.buildCityDropdownItems(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: AppColors.blackColor,
                          width: 1.0,
                        )),
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يجب اختار الحي';
                          }
                          return null;
                        },
                        value: viewModel.sectionOfFounded,
                        style: Theme.of(context).textTheme.displaySmall,
                        hint: Text('   اختار الحي',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        onChanged: (value) {
                          viewModel.setSectionOfFounded(value);
                        },
                        alignment: Alignment.center,
                        items: viewModel.buildSectionDropdownItems(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  MainFormField(
                    textInputType: TextInputType.text,
                    controller: viewModel.placesOfChild,
                    labelText: 'مكان العثور بي التفصيل',
                    validator: (value) {
                      if (value!.length > 14|| value.isEmpty) {
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
                  MainFormField(
                    textInputType: TextInputType.number,
                    controller: viewModel.phoneNumberOfReported,
                    labelText: 'رقم تليفون المبلغ ',
                    validator: (value) {
                      if (value!.length > 14|| value.isEmpty) {
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
                  GestureDetector(
                    onTap: () => viewModel.setDateTime(context),
                    child: AbsorbPointer(
                      child: MainFormField(
                        readonly: true,
                        controller: viewModel.dateOfFounded,
                        labelText: 'تاريخ الوجود ',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("هل الموجود من ذوي الاحتياجات الخاصة ؟",
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("هل يستطيع الموجود اخبار اسمه ؟",
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(": DNA ",
                          style: TextStyle(color: AppColors.fontSmoothGrey)),

                      Text("هل يوجد تحليل ",
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
                          groupValue: viewModel.selectDna,
                          onChanged: (value) {
                            viewModel.setSelectDna(value);
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
                          groupValue: viewModel.selectDna,
                          onChanged: (value) {
                            viewModel.setSelectDna(value);
                          }),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("  إرفاق صورة اساسيه",
                          style: TextStyle(
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            viewModel.pickedImage != null
                                ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  width: 110.00,
                                  height: 130,
                                  child: const Center(
                                      child: Text(
                                        "تم اضافه الصوره",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ))),
                            )
                                : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () async {
                                  viewModel.pickImage();
                                },
                                child: Container(
                                  width: 110,
                                  height: 130,
                                  color: AppColors.backgroundGrey,
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("  إرفاق باقي الصور",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                )),
                          ],
                        ),

                        Row(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                viewModel.pickedImage3 != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.black, width: 2),
                                            ),
                                            width: 110.00,
                                            height: 130,
                                            child: const Center(
                                                child:
                                                Text(
                                              "تم اضافه الصوره",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black),
                                            )
                                            )
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            viewModel.pickImage3();
                                          },
                                          child: Container(
                                            width: 110,
                                            height: 130,
                                            color: AppColors.backgroundGrey,
                                            child: const Icon(
                                              Icons.add,
                                              color: AppColors.white,
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                viewModel.pickedImage2 != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.black, width: 2),
                                            ),
                                            width: 110.00,
                                            height: 130,
                                            child: const
                                            Center(
                                              child: Text("تم اضافه الصوره",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            )),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            viewModel.pickImage2();
                                          },
                                          child: Container(
                                            width: 110,
                                            height: 130,
                                            color: AppColors.backgroundGrey,
                                            child: const Icon(
                                              Icons.add,
                                              color: AppColors.white,
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: AppColors.fontSmoothGrey,
                                width: 2.0,
                              ),
                            ),
                          ))),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MainButton("الإبلاغ عن العثور علي الموجود",
                        bgColor: AppColors.blackColor, () async {
                      viewModel.addFounded(context);
                    }),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ).setPageHorizontalPadding(context),
            ),
          ),
        ));
  }
}
