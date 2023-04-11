import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/people_status/add_missing/add_missing_people_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';

class AddMissingPeople extends StatelessWidget {
  const AddMissingPeople({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const AddMissingPeopleView(),
      viewModel: AddMissingPeopleViewModel(),
    );
  }
}

class AddMissingPeopleView extends HookView<AddMissingPeopleViewModel> {
  const AddMissingPeopleView({Key? key, reactive = true});
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
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                validator: (value) {
                  if (value!.length > 100) {
                    return "لا يمكن ان يكون اسم الاب اكير من 100 حروف";
                  }
                  if (value.length < 3) {
                    return "لا يمكن ان يكون اسم الاب اقل من 3 حروف";
                  }
                  return null;
                },
                controller: viewModel.fatherName ,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'اسم الأب / الوصي *',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field

                  labelStyle: Theme.of(context).textTheme.displaySmall,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,

              child: TextFormField(
                controller: viewModel.fatherId,
                validator: (value) {
                  if (value!.length > 100) {
                    return "لا يمكن ان يكون اكثر من 14 حرف";
                  }
                  if (value.length < 0) {
                    return "لا يمكن ان يكون اقل من 0 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'رقم بطاقة الاب / الوصي',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field

                  labelStyle: Theme.of(context).textTheme.displaySmall,

                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: viewModel.fatherPhoneNumber,
                validator: (value) {
                  if (value!.length > 11) {
                    return "لا يمكن ان يكون اكثر من 11 رقم";
                  }
                  if (value.length < 0) {
                    return "لا يمكن ان يكون اقل من 3 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'رقم تليفون الاب / الوصي',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field

                  labelStyle: Theme.of(context).textTheme.displaySmall,

                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: viewModel.nameOfMissing,
                validator: (value) {
                  if (value!.length > 100) {
                    return "لا يمكن ان يكون اكثر من 100 حرف";
                  }
                  if (value.length < 2) {
                    return "لا يمكن ان يكون اقل من 3 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'إسم الطفل',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field

                  labelStyle: Theme.of(context).textTheme.displaySmall,

                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: viewModel.ageOfMissing,
                validator: (value) {
                  if (value!.length > 3) {
                    return "لا يمكن ان يكون اكثر من 3 ارقام";
                  }
                  if (value.length < 0) {
                    return "لا يمكن ان يكون اقل من 3 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'عمر الطفل',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field

                  labelStyle: Theme.of(context).textTheme.displaySmall,

                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: viewModel.placesOfMissing,
                validator: (value) {
                  if (value!.length > 100) {
                    return "لا يمكن ان يكون اكثر من 100 حرف";
                  }
                  if (value.length < 3) {
                    return "لا يمكن ان يكون اقل من 3 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: ' مكان فقد الطفل',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10),


                  labelStyle: Theme.of(context).textTheme.displaySmall,

                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: viewModel.dateOfMissing,
                validator: (value) {
                  if (value!.length > 100) {
                    return "لا يمكن ان يكون اكثر من 100 حرف";
                  }
                  if (value.length < 3) {
                    return "لا يمكن ان يكون اقل من 3 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'تاريخ فقد الطفل',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field
                  labelStyle: Theme.of(context).textTheme.displaySmall,
                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: viewModel.hightOfMissing,
                validator: (value) {
                  if (value!.length > 200) {
                    return "لا يمكن ان يكون اكثر من 200 حرف";
                  }
                  if (value.length < 3) {
                    return "لا يمكن ان يكون اقل من 3 حرف";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'طول الطفل (اختياري)',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Adjust the padding around the input field

                  labelStyle: Theme.of(context).textTheme.displaySmall,

                  alignLabelWithHint: true,

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.greyForFileds),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Text("الجنس",style: TextStyle(color: Colors.black)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("ذكر",style: TextStyle(color: Colors.black),),
                    Radio(value: "aa", groupValue: "aa", onChanged:(value){
                      value = value;

                    }
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("ذكر",style: TextStyle(color: Colors.black),),
                    Radio(value: "aa", groupValue: "aa", onChanged:(value){
                      value = value;

                    }
                    ),
                  ],
                ),
              ],
            ),
          ],
        ).setPageHorizontalPadding(context),
      )
    );
  }
}
