import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/show_loading.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
class AddMissingPeopleViewModel extends ViewModel {
  @override
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
  DateTime? _selectedDate;
  String? gender;
  String? skinColor;
  String? colorOfEye;
  String? hairColor;
  String? specialNeeds;
  String? canTalkHisName;
  var random ;
  var random2 ;
  var random3 ;
  File? file;
  File? file2;
  File? file3;
  var pickedImage;
  var pickedImage2;
  var pickedImage3;
  String? nameOfImagePicked;
  String? nameOfImagePicked2;
  String? nameOfImagePicked3;
  var imageUrl;
  var imageUrl2;
  var imageUrl3;
  Reference? ref;
  Reference? ref2;
  Reference? ref3;
  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  addMissing(BuildContext context) async {
    if(file ==null)return AwesomeDialog(context:context,title: ("صوره"),body: const Center(child: Text("برجاء ادخال صوره",style: TextStyle(color: Colors.black),)))..show();
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      await ref!.putFile(file!);
      imageUrl =ref!.getDownloadURL();
      await ref2!.putFile(file2!);
      imageUrl2 =ref2!.getDownloadURL();
      await ref3!.putFile(file3!);
      imageUrl3 =ref3!.getDownloadURL();
      await addMissingRef.add({
        "fatherName": fatherName.text,
        "fatherId": fatherId.text,
        "dateOfMissing": dateOfMissing.value.text.toString(),
        "dateOfSend":DateFormat('yyyy/MM/dd').format(DateTime.now()).toString(),
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
        "imageUrl": await imageUrl,
        "imageUrl2": await imageUrl2,
        "imageUrl3": await imageUrl3,
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pushNamed(context , AppRouter.successfulMessage);
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
  pickImage()async{
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      file =File(pickedImage.path);
      random =Random().nextInt(100000);
      nameOfImagePicked = basename(pickedImage.path);
      ref = FirebaseStorage.instance.ref("images").child("$nameOfImagePicked");
    }
    notifyListeners();
  }
  pickImage2()async{
    pickedImage2 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage2 != null){
      file2 =File(pickedImage2.path);
      random2 =Random().nextInt(100000);
      nameOfImagePicked2 = basename(pickedImage2.path);
      ref2 = FirebaseStorage.instance.ref("images").child("$nameOfImagePicked2");
    }
    notifyListeners();
  }
  pickImage3()async{
    pickedImage3 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage3 != null){
      file3 =File(pickedImage3.path);
      random3 =Random().nextInt(100000);
      nameOfImagePicked3 = basename(pickedImage3.path);
      ref3 = FirebaseStorage.instance.ref("images").child("$nameOfImagePicked3");
    }
    notifyListeners();
  }
  setDateTime(context) async{
   final DateTime? pickedDate =  await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    //dateOfMissing = pickedDate  ;


      if (pickedDate != null && pickedDate != _selectedDate) {
        dateOfMissing.text =DateFormat('yyyy/MM/dd').format(pickedDate).toString();
        _selectedDate =  DateFormat('yyyy/MM/dd').format(pickedDate).toString() as DateTime? ;
        notifyListeners();
      }

  }
}