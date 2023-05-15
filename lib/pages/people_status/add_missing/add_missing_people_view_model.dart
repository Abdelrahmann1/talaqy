import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/show_loading.dart';
class AddMissingPeopleViewModel extends ViewModel {
  @override
  void init() {
    super.init();}
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
  DateTime? pickedDate;
  String? gender;
  String? skinColor;
  String? colorOfEye;
  String? hairColor;
  String? specialNeeds;
  String? canTalkHisName;

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
        "MoreDetails": moreDetails.text,
        "gender": gender.toString(),
        "skinColor": skinColor.toString(),
        "colorOfEye": colorOfEye.toString(),
        "hairColor": hairColor.toString(),
        "specialNeeds": specialNeeds.toString(),
        "canTalkHisName": canTalkHisName.toString(),
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pushNamed(context, AppRouter.successfulMessage);
    }
  }
  setGender(val){
    gender = val;
    notifyListeners();
  }
  setSkinColor(val){
    skinColor = val;
    notifyListeners();
  }
  setColorOfEye(val){
    colorOfEye = val;
    notifyListeners();
  }
  setHairColor(val){
    hairColor = val;
    notifyListeners();
  }
  setSpecialNeeds(val){
    specialNeeds = val;
    notifyListeners();
  }
  setCanTalk(val){
    canTalkHisName = val;
    notifyListeners();
  }

}