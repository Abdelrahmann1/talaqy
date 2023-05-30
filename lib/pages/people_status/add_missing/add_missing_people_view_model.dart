import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
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
  TextEditingController urRoleOfChild = TextEditingController();
  DateTime? _selectedDate;
  String? gender;
  String? countryOfMissing;
  String? cityOfMissing;
  String? sectionOfMissing;
  String? skinColor;
  String? colorOfEye;
  String? hairColor;
  String? specialNeeds;
  String? canTalkHisName;
  dynamic random;

  dynamic random2;

  dynamic random3;

  File? file;
  File? file2;
  File? file3;
  dynamic pickedImage;
  dynamic pickedImage2;
  dynamic pickedImage3;
  String? nameOfImagePicked;
  String? nameOfImagePicked2;
  String? nameOfImagePicked3;
  dynamic imageUrl;
  dynamic imageUrl2;
  dynamic imageUrl3;
  Reference? ref;
  Reference? ref2;
  Reference? ref3;
  CollectionReference addMissingRef =
      FirebaseFirestore.instance.collection("Missing People");

  addMissing(BuildContext context) async {
    if (file == null) {
      return AwesomeDialog(
          context: context,
          title: ("صوره"),
          body: const Center(
              child: Text(
            "برجاء ادخال صوره",
            style: TextStyle(color: Colors.black),
          )))..show();
    }
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      await ref!.putFile(file!);
      imageUrl = ref!.getDownloadURL();
      await ref2!.putFile(file2!);
      imageUrl2 = ref2!.getDownloadURL();
      await ref3!.putFile(file3!);
      imageUrl3 = ref3!.getDownloadURL();
      await addMissingRef.add({
        "fatherName": fatherName.text,
        "fatherId": fatherId.text,
        "dateOfMissing": dateOfMissing.value.text.toString(),
        "dateOfSend":
            DateFormat('yyyy/MM/dd').format(DateTime.now()).toString(),
        "fatherPhoneNumber": fatherPhoneNumber.text,
        "nameOfMissing": nameOfMissing.text,
        "ageOfMissing": ageOfMissing.text,
        "placesOfMissing": placesOfMissing.text,
        "CountryOfFounded": countryOfMissing,
        "CityOfFounded": cityOfMissing,
        "SecitonOfFounded": sectionOfMissing,
        "heightOfMissing": heightOfMissing.text,
        "MoreDetails": moreDetails.text,
        "urRoleOfChild": urRoleOfChild.text,
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
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, AppRouter.successfulMessage);
    }
  }

  setGender(val) {
    gender = val;
    notifyListeners();
  }

  setCountryOfMissing(val) {
    countryOfMissing = val;
    cityOfMissing = null; // Reset selected country
    sectionOfMissing = null;
    notifyListeners();
  }

  setCityOfMissing(val) {
    cityOfMissing = val;
    sectionOfMissing = null;
    notifyListeners();
  }

  setSectionOfMissing(val) {
    sectionOfMissing = val;
    notifyListeners();
  }

  setCairo(val) {
    gender = val;
    notifyListeners();
  }

  setSkinColor(val) {
    skinColor = val;
    notifyListeners();
  }

  setColorOfEye(val) {
    colorOfEye = val;
    notifyListeners();
  }

  setHairColor(val) {
    hairColor = val;
    notifyListeners();
  }

  setSpecialNeeds(val) {
    specialNeeds = val;
    notifyListeners();
  }

  setCanTalk(val) {
    canTalkHisName = val;
    notifyListeners();
  }

  pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      random = Random().nextInt(100000);
      nameOfImagePicked = basename(pickedImage.path);
      ref = FirebaseStorage.instance.ref("images").child("$nameOfImagePicked");
    }
    notifyListeners();
  }

  pickImage2() async {
    pickedImage2 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage2 != null) {
      file2 = File(pickedImage2.path);
      random2 = Random().nextInt(100000);
      nameOfImagePicked2 = basename(pickedImage2.path);
      ref2 =
          FirebaseStorage.instance.ref("images").child("$nameOfImagePicked2");
    }
    notifyListeners();
  }

  pickImage3() async {
    pickedImage3 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage3 != null) {
      file3 = File(pickedImage3.path);
      random3 = Random().nextInt(100000);
      nameOfImagePicked3 = basename(pickedImage3.path);
      ref3 =
          FirebaseStorage.instance.ref("images").child("$nameOfImagePicked3");
    }
    notifyListeners();
  }

  setDateTime(context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (pickedDate != null && pickedDate != _selectedDate) {
      dateOfMissing.text =
          DateFormat('yyyy/MM/dd').format(pickedDate).toString();
      _selectedDate =
          DateFormat('yyyy/MM/dd').format(pickedDate).toString() as DateTime?;
      notifyListeners();
    }
  }

  Map<String, Map<String, List<String>>> citiesByCountry = {
    'مصر': {
      'القاهرة': [
        'المعادي',
        'الزمالك',
        'مصر الجديدة',
        'الدقي',
        'المهندسين',
        'مدينة نصر',
        'جاردن سيتي',
        'العجوزة',
        'محرم بك',
        'القاهرة الجديدة',
      ],
      'الإسكندرية': [
        'الرمل',
        'المنتزة',
        'سموحة',
        'اللوران',
        'المندرة',
        'الشاطبي',
        'الأزاريطة',
        'الجمرك',
        'العطارين',
        'أبو قير',
      ],
      'الإسماعيلية':[
  'الشهداء',
  'القصاصين',
  'المنتزه',
  'الشيخ زايد',
  'التل الكبير',
  'فايد',
  'التل الصغير',
  'المنشية',
  'الحي السادس',
  'الحي السابع',
  ],
      'أسوان': [
  'مدينة أسوان',
  'النصر',
  'الساحل الشمالي',
  'منطقة السد',
  'السوق الشعبي',
  'الهدايا',
  'المنيل',
  'الجلاء',
  'دروة الرمال',
  'منطقة الحي السكني',
  ],
      'أسيوط':[
        'المدينة الجديدة',
        'الكوثر',
        'الأزهري',
        'الحي العربي',
        'المناخ',
        'السد العالي',
        'الحي السكني',
        'الجامعة',
        'السلام',
        'البداري',
      ],
      'الأقصر':
      ['Lagos', 'Abuja', 'Kano'],
      'البحر الأحمر': ['Lagos', 'Abuja', 'Kano'],
      'البحيرة': ['Lagos', 'Abuja', 'Kano'],
      'بني سويف': ['Lagos', 'Abuja', 'Kano'],
      'بورسعيد': ['Lagos', 'Abuja', 'Kano'],
      'جنوب سيناء': ['Lagos', 'Abuja', 'Kano'],
      'الجيزة': ['Lagos', 'Abuja', 'Kano'],
      'الدقهلية': ['Lagos', 'Abuja', 'Kano'],
      'دمياط': ['Lagos', 'Abuja', 'Kano'],
      'سوهاج': ['Lagos', 'Abuja', 'Kano'],
      'السويس': ['Lagos', 'Abuja', 'Kano'],
      'الشرقية': ['Lagos', 'Abuja', 'Kano'],
      'شمال سيناء': ['Lagos', 'Abuja', 'Kano'],
      'الغربية': ['Lagos', 'Abuja', 'Kano'],
      'الفيوم': ['Lagos', 'Abuja', 'Kano'],
      'القليوبية': ['Lagos', 'Abuja', 'Kano'],
      'قنا': ['Lagos', 'Abuja', 'Kano'],
      'كفر الشيخ': ['Lagos', 'Abuja', 'Kano'],
      'مطروح': ['Lagos', 'Abuja', 'Kano'],
      'المنوفية': ['Lagos', 'Abuja', 'Kano'],
      'المنيا': ['Lagos', 'Abuja', 'Kano'],
      'الوادي الجديد': ['Lagos', 'Abuja', 'Kano'],
    },
    'Asia': {
      'India': ['Mumbai', 'Delhi', 'Bangalore'],
      'China': ['Beijing', 'Shanghai', 'Guangzhou'],
    },
    'Europe': {
      'France': ['Paris', 'Marseille', 'Lyon'],
      'Germany': ['Berlin', 'Munich', 'Hamburg'],
    },
  };

  List<DropdownMenuItem<String>> buildCountryDropdownItems() {
    return citiesByCountry.keys.map((String continent) {
      return DropdownMenuItem<String>(
        value: continent,
        child: Text(continent),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> buildCityDropdownItems() {
    if (countryOfMissing == null) return [];

    return citiesByCountry[countryOfMissing]!.keys.map((String country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(country),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> buildSectionDropdownItems() {
    if (cityOfMissing == null) return [];

    return citiesByCountry[countryOfMissing]![cityOfMissing]!
        .map((String city) {
      return DropdownMenuItem<String>(
        value: city,
        child: Text(city),
      );
    }).toList();
  }
}
