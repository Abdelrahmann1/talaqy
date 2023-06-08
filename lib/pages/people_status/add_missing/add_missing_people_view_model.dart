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

import '../../../utils/app_colors.dart';

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
  String? selectDna;
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
          )))
        ..show();
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
        "dateOfSend": DateFormat('yyyy/MM/dd').format(DateTime.now()).toString(),
        "fatherPhoneNumber": fatherPhoneNumber.text,
        "nameOfMissing": nameOfMissing.text,
        "ageOfMissing": ageOfMissing.text,
        "placesOfMissing": placesOfMissing.text,
        "CountryOfMissing": countryOfMissing,
        "CityOfMissing": cityOfMissing,
        "SecitonOfMissing": sectionOfMissing,
        "heightOfMissing": heightOfMissing.text,
        "MoreDetails": moreDetails.text,
        "urRoleOfChild": urRoleOfChild.text,
        "gender": gender.toString(),
        "DNA": selectDna.toString(),
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
  setSelectDna(val) {
    selectDna = val;
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
        "حى الزيتون",
        "حى الساحل",
        "حى الشرابية",
        "حى حدائق القبة",
        "حى روض الفرج",
        "حى شبرا",
        "الشروق",
        "مدينة بدر",
        "القاهرة الجديدة",
        'حى 15 مايو',
        'حى البساتين',
        'حى التبين',
        'حى الخليفة',
        'حى السيدة زينب',
        'حى المعادى',
        'حى المعصرة',
        'حى المقطم',
        'حى حلوان',
        'حى دار السلام',
        'حى طرة',
        'حى مصر القديمة',
        'حى الأميرية',
        'حى الزاوية الحمراء',
        'حى مدينة نصر غرب',
        'حى مصر الجديدة',
        'حى الأزبكية',
        'حى الموسكى',
        'حى الوايلى',
        'حى باب الشعرية',
        'حى بولاق',
        'حى عابدين',
        'حى غرب',
        'حى منشأة ناصر',
        'حى وسط',
        'حى السلام ثانى',
        'حى المرج',
        ' حى المطرية',
        'حى النزهة',
        'حى عين شمس',
        'حى مدينة نصر شرق',
        "حى السلام أول",

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
      'الإسماعيلية': [
      "المنتزة",
      "شرق الإسكندرية",
      "وسط الإسكندرية",
      "الجمرك",
      "العجمي",
      "العامرية",
      "برج العرب",
        "يرج العرب الجديد",
        "المنتزة ثان",
        "حي العامري ثان",
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
      'أسيوط': [
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
        "ديروط",
        "القوصية",
        "الفتح",
        "منفلوط",
      ],
      'البحر الأحمر': [
        "حي السقالة",
        "حي الدهار",
        "حي الأحياء",
        "رأس غارب",
        "القُصير",
        " سفاجا",
        "مرسى علم",
        " حلايب",
        "شلاتين",
      ],
      'البحيرة': [
        "رشيد",
        "شبراخيت",
        "ايتاي البارود",
        "أبو حمص",
        "حوش عيسي",
        "كفر الدوار",
        "الدلنجات",
        "كوم حمادة",
        "دمنهور",
        "المحمودية",
        "ادكو",
        "أبو المطامير",
        "الرحمانية",
        "وادي النطرون",
        "بدر",
        "النوبارية الجديدة",
      ],
      'بني سويف': [
        "بني سويف",
        "بني سويف الجديدة",
        "ناصر",
        "اهناسيا",
        "ببا",
        "سمسطا",
        "الفشن",
      ],
      'بورسعيد': [
        "شرق بورسعيد",
        "غرب بورسعيد",
        "جنوب بورسعيد",
        "العرب",
        "المناخ",
        "الضواحي",
        "الزهور",
        "بور فؤاد",
      ],
      'جنوب سيناء': [
        "أبو رديس",
        "أبو زنيمة",
        "نويبع",
        "طابا",
        "رأس سدر",
        "دهب",
        "شرم الشيخ",
        "سانت كاترين",
        "طور سيناء",
      ],
      'الجيزة': [
        "المهندسين",
        "حى شمال الجيزه",
        "حى الدقى",
        "حى العجوزه",
        "بولاق الدكرور",
        "حى العمرانيه",
        "حى الهرم",
        "حى الوراق",
        "حى جنوب الجيزه",
        "الشيخ زايد",
        "منشأه القناطر",
        "اوسيم",
        "الواحات البحرية",
        "أبو النمرس",
        "البدرشين",
        "العياط",
        "الصف",
        "اطفيح",
        "الباويطي",
        "السادس من أكتوبر",
        "الحوامدية",
        "كرداسة",
        "حي العمرانية",
        "حي الوراق",
      ],
      'الدقهلية': [
          'المنصورة',
          'شرق المنصورة',
          'غرب المنصورة',
          'طلخا',
          'ميت غمر',
          'المنزلة',
          'دكرنس',
          'منية النصر',
          'اجا',
          'السنبلاوين',
        "بني عبيد",
        "الجمالية",
        "شربين",

      ],
      'دمياط': [
        "دمياط",
        "دمياط الجديدة",
        "عزبة البرج",
        "فاركو",
        "الروضة",
        "الزرقا",
        "السرو",
        "كفر سعد",
        "ميت أبو غالب",
        "كفر البطيخ",
        "راس البر",
      ],
      'سوهاج': [
        " سوهاج",
        "حي شرق سوهاج",
        "حي غرب سوهاج",
        "حي الكوثر",
        "اخميم",
        "البلينا",
        "المراغة",
        "المنشاة",
        "دار السلام",
        "جرجا",
        "جهينة",
        "ساقلتة",
        "طما",
        "طهطا",
        "العسيرات",
        "سوهاج الجديدة",
        "أخميم الجديدة",
        "الزمالك",
      ],
      'السويس': [
        "السويس",
        "الأربعين",
        "الجناين",
        "فيصل",
        "خليج السويس",
        "عتاقة",
      ],
      'الشرقية': [
        "الزقازيق",
        "حي اول الزقازيق",
        "حي ثان الزقازيق",
        "الحسينية",
        "صان الحجر القبلية",
        "فاقوس",
        "بلبيس",
        "مينا القمح",
        "أبو حماد",
        "أولاد صقر",
        "العاشر من رمضان",
        "أبو كبير",
        "القنايات",
        "مشتول السةق",
        "ديرب نجم",
        "الابراهيمية",
        "ههيا",
        "القرين",
        "الصالحية الجديدة",
      ],
      'شمال سيناء': [
        "بئر العبد",
        "نخل",
        "الحسنة",
        "العريش",
        "الشيخ زويد",
        "رفح",
      ],
      'الغربية': [
      "طنطا",
      "اول طنطا",
      "ثان طنطا",
      "اول المحل الكبرى",
      "ثان المحلة الكبرى",
      "كفر الزيات",
      "السنطة",
        "بسيون",
        "زفتي",
        "سمنودة",
        "قطور",
      ],
      'الفيوم': [
        "الفيوم",
        "الفيوم الجديدة",
        "إبشواي",
        "طامية",
        "يوسف الصديق",
        "سنورس",
        "حى الجون",
        "حى جنوب الفيوم",
        "حى غرب الفيوم",
        "حى شرق الفيوم",
      ],
      'القليوبية': [
        "شبين القناطر",
        "قها",
        "العبور",
        "قليوب",
        "بنها",
        "كفر شكر",
        "الخصوص",
        "الخانكة",
        "القناطر الخيرية",
        "غرب شبرا الخيمة",
        "شرق شبراالخيمة",
        "طوخ",
      ],
      'قنا': [
       "فرشوط",
       "قنا",
       "أبو تشت",
       "نجع حمادي",
       "الوقف",
       "دشنا",
       "قفط",
       "قوص",
       " نقادة",
       "قنا الجديدة",
       "غرب قنا",
      ],
      'كفر الشيخ': [
        "كفر الشيخ",
        "سيدي غازي",
        "دسوق",
        "فوه",
        "مطوبس",
        "قلين",
        "سيدي سالم",
        "الرياض",
        "بيلا",
        "الحامول",
        "البرلس",
        "بلطيم",
        "مصيف بلطيم",
        "برج البرلس",
      ],
      'مطروح': [

        "مرسي مطروح",
        "الحمام",
        "العلمين",
        "الضبعة",
        "النجيلة",
        "سيدي براني",
        "السلوم",
        "سيوة",
      ],
      'المنوفية': [
        "شبين الكوم",
        "شرق شبين الكوم",
        "غرب شبين الكوم",
        "منوف",
        "تويسنا",
        "الباجور",
        "اشمون",
        "الشهداء",
        "السادات",
        "بركة السبع",
      ],
      'المنيا': [
        "المنيا",
        "ملوي",
        "العدوة",
        "مغاغة",
        "بني مزار",
        "سمالوط",
        "دير مواس",
        "أبو قرقاس",
        "المنيا الجديدة",
      ],
      'الوادي الجديد': [
        "الداخلة",
        "الخارجة",
        "الفرافرة",
        "باريس",
        "بلاط",
        "توشكى الجديدة",
      ],
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
  Future<void> showAlertDialog(BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            title: const Center(
                child: Text(
                  "خطا في تسجيل الدخول ",
                  style: TextStyle(fontSize: 12),
                )),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "failureMassage",
                  style: TextStyle(color: AppColors.blackColor),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("حسنا"))
            ],
          );
        }

    ).then((value) => Future.value()); // Return a non-nullable Future with a value of null
  }
}
