import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
class EditMissingViewModel extends ViewModel {
  var docId;
  EditMissingViewModel({this.docId});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fatherName = TextEditingController();
  TextEditingController fatherId = TextEditingController();
  TextEditingController fatherPhoneNumber = TextEditingController();
  TextEditingController nameOfMissing = TextEditingController();
  TextEditingController ageOfMissing = TextEditingController();
  TextEditingController placesOfMissing = TextEditingController();
  TextEditingController dateOfMissing = TextEditingController();
  TextEditingController heightOfMissing = TextEditingController();
  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  editMissing() async {
    print(docId);
    // var formData = formKey.currentState;
    // if (formData!.validate()) {
    //   showLoading(context);
    //   formData.save();
    //   await addMissingRef.doc().update({
    //     "fatherName": fatherName.text,
    //     "fatherId": fatherId.text,
    //     "dateOfMissing": dateOfMissing.text,
    //     "fatherPhoneNumber": fatherPhoneNumber.text,
    //     "nameOfMissing": nameOfMissing.text,
    //     "ageOfMissing": ageOfMissing.text,
    //     "placesOfMissing": placesOfMissing.text,
    //     "heightOfMissing": heightOfMissing.text,
    //     "userId":FirebaseAuth.instance.currentUser!.uid,
    //   });
    //   Navigator.pushNamed(context, AppRouter.successfulmessage);
    // }
  }
}
