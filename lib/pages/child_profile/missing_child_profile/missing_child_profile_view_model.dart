import 'package:carousel_slider/carousel_controller.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:share_plus/share_plus.dart';

class MissingChildProfileViewModel extends ViewModel {
  CarouselController buttonCarouselController = CarouselController();
  int currentIndex = 0;
  var docId;
  var list;
  String? fatherPhoneNumber;
  MissingChildProfileViewModel({required this.docId,required this.list});
  void init() {
    setPhoneNumber();
    super.init();
  }

  setPhoneNumber(){
     fatherPhoneNumber = list["fatherPhoneNumber"];
     notifyListeners();

  }
  void shareData() {
    Map<String, dynamic> sharedData = {
      "اسم الطفل المفقود": list["nameOfMissing"],
      "مدينة الطفل المفقود": list["CityOfMissing"],
      "عمر المفقود": list["ageOfMissing"],
      "تاريخ المفقود": list["dateOfMissing"],
      "اسم الأب": list["fatherName"],
      "ماكن الفقد": list["placesOfMissing"],
      "صورة الطفل": list["imageUrl"],
    };
    Share.share(sharedData.toString());

  }


  onPageChanged( index){
    currentIndex=index;
    notifyListeners();
  }

  }




