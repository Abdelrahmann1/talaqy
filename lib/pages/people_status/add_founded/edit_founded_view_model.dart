import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/widgets/show_loading.dart';

import '../../../utils/app_router.dart';

class EditFoundedViewModel extends ViewModel {
  var docId;
  var list;
  EditFoundedViewModel({required this.docId, required this.list});
  @override
  void init() {
    super.init();
    setNameOfChild();
    setAgeOfChild();
    setClothesOfChild();
    setDateOfFounded();
    setPlacesOfChild();
    setPhoneNumberOfReported();
    setMoreDetails();
  }
  setNameOfChild(){
    nameOfChild.text=list["nameOfChild"];
    notifyListeners();
  }
  setAgeOfChild(){
    ageOfChild.text=list["ageOfChild"];
    notifyListeners();
  }
  setClothesOfChild(){
    clothesOfChild.text=list["clothesOfChild"];
    notifyListeners();
  }
  setDateOfFounded(){
    dateOfFounded.text=list["dateOfFounded"];
    notifyListeners();
  }
  setPlacesOfChild(){
    placesOfChild.text=list["placesOfChild"];
    notifyListeners();
  }
  setPhoneNumberOfReported(){
    phoneNumberOfReported.text=list["phoneNumberOfReported"];
    notifyListeners();
  }
  setMoreDetails(){
    moreDetails.text=list["moreDetails"];
    notifyListeners();
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameOfChild = TextEditingController();
  TextEditingController ageOfChild = TextEditingController();
  TextEditingController clothesOfChild = TextEditingController();
  TextEditingController dateOfFounded = TextEditingController();
  TextEditingController placesOfChild = TextEditingController();
  TextEditingController phoneNumberOfReported = TextEditingController();
  TextEditingController moreDetails = TextEditingController();
  CollectionReference addFoundedRef =
      FirebaseFirestore.instance.collection("Founded People");
  editFounded() async {
    print(docId);
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      await addFoundedRef.doc(docId).update({
        "nameOfChild":nameOfChild.text,
        "ageOfChild":ageOfChild.text,
        "clothesOfChild":clothesOfChild.text,
        "dateOfFounded":dateOfFounded.text,
        "placesOfChild":placesOfChild.text,
        "phoneNumberOfReported":phoneNumberOfReported.text,
        "moreDetails":moreDetails.text,
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
    }
  }
}
