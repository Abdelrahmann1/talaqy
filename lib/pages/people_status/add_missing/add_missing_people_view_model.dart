import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/show_loading.dart';
class AddMissingPeopleViewModel extends ViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fatherName = TextEditingController();
  TextEditingController fatherId = TextEditingController();
  TextEditingController fatherPhoneNumber = TextEditingController();
  TextEditingController nameOfMissing = TextEditingController();
  TextEditingController ageOfMissing = TextEditingController();
  TextEditingController placesOfMissing = TextEditingController();
  TextEditingController dateOfMissing = TextEditingController();
  TextEditingController heightOfMissing = TextEditingController();
  DateTime? pickedDate;
  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  setDateTime()async{
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    {
        dateOfMissing = pickedDate as TextEditingController;
        notifyListeners();
    }
  }
  addMissing() async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      await addMissingRef.add({
        "fatherName": fatherName.text,
        "fatherId": fatherId.text,
        "dateOfMissing": dateOfMissing.text,
        "fatherPhoneNumber": fatherPhoneNumber.text,
        "nameOfMissing": nameOfMissing.text,
        "ageOfMissing": ageOfMissing.text,
        "placesOfMissing": placesOfMissing.text,
        "heightOfMissing": heightOfMissing.text,
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pushNamed(context, AppRouter.successfulMessage);
    }
  }
}