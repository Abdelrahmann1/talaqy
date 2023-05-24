import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/main_button.dart';
import '../../../widgets/missed_form_field.dart';
import 'edit_missing_view_model.dart';

class EditMissingScreen extends StatelessWidget {
  var docid;
  var list;
  EditMissingScreen({Key? key, this.docid,this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => EditMissingView(),
      viewModel: EditMissingViewModel(docId: docid,list: list),
    );
  }
}
class EditMissingView extends HookView<EditMissingViewModel> {
  EditMissingView({Key? key, reactive = true});
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
          leading: Container(),
          centerTitle: true,
          title: Text(
            'تعديل البيانات عن طفل مفقود',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        body: Form(
          key: viewModel.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                MainFormField(
                  // initialValue: viewModel.list["fatherName"].toString(),
                  textInputType: TextInputType.text,
                  controller: viewModel.fatherName,
                  labelText: 'اسم الأب / الوصي *',
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
                  // initialValue: viewModel.list["fatherId"].toString(),
                  textInputType: TextInputType.number,
                  controller: viewModel.fatherId,
                  labelText: 'رقم بطاقة الاب / الوصي',
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
                MainFormField(
                  // initialValue: viewModel.list["fatherPhoneNumber"].toString(),

                  textInputType: TextInputType.number,
                  controller: viewModel.fatherPhoneNumber,
                  labelText: 'رقم تليفون الاب / الوصي',
                  validator: (value) {
                    if (value!.length > 11) {
                      return "لا يمكن ان يكون اكثر من 11 رقم";
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
                  // initialValue: viewModel.list["nameOfMissing"].toString(),

                  controller: viewModel.nameOfMissing,
                  textInputType: TextInputType.text,
                  labelText: 'إسم الطفل',
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
                  // initialValue: viewModel.list["ageOfMissing"].toString(),

                  textInputType: TextInputType.number,
                  controller: viewModel.ageOfMissing,
                  labelText: 'عمر الطفل',
                  validator: (value) {
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
                  // initialValue: viewModel.list["placesOfMissing"].toString(),

                  textInputType: TextInputType.text,
                  controller: viewModel.placesOfMissing,
                  labelText: 'مكان فقد الطفل',
                  validator: (value) {
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
                  // initialValue: viewModel.list["dateOfMissing"].toString(),

                  textInputType: TextInputType.datetime,
                  controller: viewModel.dateOfMissing,
                  labelText: 'تاريخ فقد الطفل',
                ),
                const SizedBox(
                  height: 13,
                ),
                MainFormField(
                  // initialValue: viewModel.list["heightOfMissing"].toString(),
                  textInputType: TextInputType.number,
                  controller: viewModel.heightOfMissing,
                  labelText: 'طول الطفل (اختياري)',
                ),
                const SizedBox(height: 10,),
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
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(" تعديل البيانات", bgColor: AppColors.blackColor,
                      () async {
                    viewModel.editMissing();
                  }),
                )
              ],
            ).setPageHorizontalPadding(context),
          ),
        ));
  }
}
