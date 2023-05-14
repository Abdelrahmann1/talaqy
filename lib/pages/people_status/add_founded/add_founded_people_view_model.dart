import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/show_loading.dart';
class AddFoundedPeopleViewModel extends ViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameOfChild = TextEditingController();
  TextEditingController ageOfChild = TextEditingController();
  TextEditingController clothesOfChild = TextEditingController();
  TextEditingController placesOfChild = TextEditingController();
  TextEditingController phoneNumberOfReported = TextEditingController();
  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Founded People");
  Future addFounded() async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      await addMissingRef.add({
        "nameOfChild": nameOfChild.text,
        "ageOfChild": ageOfChild.text,
        "clothesOfChild": clothesOfChild.text,
        "placesOfChild": placesOfChild.text,
        "phoneNumberOfReported": phoneNumberOfReported.text,
        "userId":FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pushNamed(context, AppRouter.successfulMessage);
    }
  }
}
