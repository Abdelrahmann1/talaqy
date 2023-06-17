import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/show_loading.dart';
import 'package:path/path.dart';
import 'package:intl/src/intl/date_format.dart';

class AddFoundedPeopleViewModel extends ViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameOfChild = TextEditingController();
  TextEditingController ageOfChild = TextEditingController();
  TextEditingController clothesOfChild = TextEditingController();
  TextEditingController dateOfFounded = TextEditingController();
  TextEditingController placesOfChild = TextEditingController();
  TextEditingController phoneNumberOfReported = TextEditingController();
  TextEditingController moreDetails = TextEditingController();
  String? gender;
  String? countryOfFounded;
  String? sectionOfFounded;
  String? cityOfFounded;
  String? skinColor;
  String? colorOfEye;
  String? hairColor;
  String? specialNeeds;
  String? canTalkHisName;
  String? selectDna;
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
  DateTime? _selectedDate;
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
      ref2 = FirebaseStorage.instance.ref("images").child("$nameOfImagePicked2");
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
  setGender(val) {
    gender = val;
    notifyListeners();
  }
  setCountryOfFounded(val) {
    countryOfFounded = val;
    cityOfFounded = null; // Reset selected country
    sectionOfFounded = null;
    notifyListeners();
  }
  setCityOfFounded(val) {
    cityOfFounded = val;
    sectionOfFounded = null;
    notifyListeners();
  }
  setSectionOfFounded(val) {
    sectionOfFounded = val;
    notifyListeners();
  }
  setSkinColor(val) {
    skinColor = val;
    notifyListeners();
  }
  setSelectDna(val) {
    selectDna = val;
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
    if (countryOfFounded == null) return [];

    return citiesByCountry[countryOfFounded]!.keys.map((String country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(country),
      );
    }).toList();
  }
  List<DropdownMenuItem<String>> buildSectionDropdownItems() {
    if (cityOfFounded == null) return [];

    return citiesByCountry[countryOfFounded]![cityOfFounded]!
        .map((String city) {
      return DropdownMenuItem<String>(
        value: city,
        child: Text(city),
      );
    }).toList();
  }
  CollectionReference addMissingRef =
      FirebaseFirestore.instance.collection("Founded People");
  Future addFounded(BuildContext context) async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);
      formData.save();
      try{
        await ref!.putFile(file!);
        imageUrl = ref!.getDownloadURL();
      }catch(error){
        print("Failed to upload file: $error");
        imageUrl = null;
      }
      try{
        await ref2!.putFile(file2!);
        imageUrl2 = ref2!.getDownloadURL();
      }catch(error){
        print("Failed to upload file: $error");
        imageUrl2 = null;

      }
      try{
        await ref3!.putFile(file3!);
        imageUrl3 = ref3!.getDownloadURL();

      }catch(error){
        print("Failed to upload file: $error");
        imageUrl3 = null;

      }      await addMissingRef.add({
        "nameOfChild": nameOfChild.text,
        "ageOfChild": ageOfChild.text,
        "clothesOfChild": clothesOfChild.text,
        "placesOfChild": placesOfChild.text,
        "phoneNumberOfReported": phoneNumberOfReported.text,
        "CountryOfFounded": countryOfFounded,
        "CityOfFounded": cityOfFounded,
        "sectionOfFounded": sectionOfFounded,
        "gender": gender.toString(),
        "skinColor": skinColor.toString(),
        "colorOfEye": colorOfEye.toString(),
        "DNA": selectDna.toString(),
        "hairColor": hairColor.toString(),
        "specialNeeds": specialNeeds.toString(),
        "canTalkHisName": canTalkHisName.toString(),
        "moreDetails": moreDetails.text,
        "dateOfFounded": dateOfFounded.value.text.toString(),
        "dateOfSend":DateFormat('yyyy/MM/dd').format(DateTime.now()).toString(),
        "imageUrl": await imageUrl??"",
        "imageUrl2": await imageUrl2??"",
        "imageUrl3": await imageUrl3??"",
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.of(context).pop();
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.successfulMessage,(Route<dynamic> route) => false);

    }
  }
  setDateTime(context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (pickedDate != null && pickedDate != _selectedDate) {
      dateOfFounded.text =
          DateFormat('yyyy/MM/dd').format(pickedDate).toString();
      _selectedDate =
          DateFormat('yyyy/MM/dd').format(pickedDate).toString() as DateTime?;
      notifyListeners();
    }
  }
}
