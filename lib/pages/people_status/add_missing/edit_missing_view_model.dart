import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/widgets/show_loading.dart';

import '../../../utils/app_router.dart';
class EditMissingViewModel extends ViewModel {
  var docId;
  var list;
  String? fatherNameEdite;
  EditMissingViewModel({required this.docId,required this.list});
  @override
  void init() {
    setFatherName();
    setMoreDetails();
    setFatherId();
    setFatherPhoneNumber();
    setNameOfMissing();
    setAgeOfMissing();
    setDateOfMissing();
    setPlacesOfMissing();
    setHeightOfMissing();
    super.init();
  }
  setFatherName(){
    fatherName.text=list["fatherName"];
    notifyListeners();
  }
  setFatherId(){
    fatherId.text=list["fatherId"];
    notifyListeners();
  }
  setFatherPhoneNumber(){
    fatherPhoneNumber.text=list["fatherPhoneNumber"];
    notifyListeners();
  }
  setNameOfMissing(){
    nameOfMissing.text=list["nameOfMissing"];
    notifyListeners();
  }
  setAgeOfMissing(){
    ageOfMissing.text=list["ageOfMissing"];
    notifyListeners();
  }
  setPlacesOfMissing(){
    placesOfMissing.text=list["placesOfMissing"];
    notifyListeners();
  }
  setDateOfMissing(){
    dateOfMissing.text=list["dateOfMissing"];
    notifyListeners();
  }
  setHeightOfMissing(){
    heightOfMissing.text=list["heightOfMissing"];
    notifyListeners();
  }
  setMoreDetails(){
    moreDetails.text=list["MoreDetails"];
    notifyListeners();
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fatherName = TextEditingController();
  TextEditingController fatherId = TextEditingController();
  TextEditingController fatherPhoneNumber = TextEditingController();
  TextEditingController nameOfMissing = TextEditingController();
  TextEditingController ageOfMissing = TextEditingController();
  TextEditingController placesOfMissing = TextEditingController();
  TextEditingController dateOfMissing = TextEditingController();
  TextEditingController heightOfMissing = TextEditingController();
  TextEditingController moreDetails = TextEditingController();
  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  editMissing() async {
    print(docId);
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      await addMissingRef.doc(docId).update({
        "fatherName": fatherName.text,
        "fatherId": fatherId.text,
        "dateOfMissing": dateOfMissing.text,
        "fatherPhoneNumber": fatherPhoneNumber.text,
        "nameOfMissing": nameOfMissing.text,
        "ageOfMissing": ageOfMissing.text,
        "placesOfMissing": placesOfMissing.text,
        "heightOfMissing": heightOfMissing.text,
        "MoreDetails": moreDetails.text,
        "userId":FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.popAndPushNamed(context, AppRouter.successfulEditMessage);
    }
  }
}
