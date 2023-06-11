import 'package:carousel_slider/carousel_slider.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:share_plus/share_plus.dart';

class FoundedChildProfileViewModel extends ViewModel {
  dynamic docId;
  dynamic list;
  String? phoneNumberOfReported;
  int currentIndex = 0;

  CarouselController buttonCarouselController = CarouselController();

  FoundedChildProfileViewModel({required this.docId, required this.list});
  void init() {
    setPhoneNumber();
    super.init();
  }

  onPageChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  setPhoneNumber() {
    phoneNumberOfReported = list["phoneNumberOfReported"];
    notifyListeners();
  }
  void shareData() {
    Map<String, dynamic> sharedData = {
      "اسم الطفل الموجود ": list["nameOfChild"],
      "ملابس اطفال": list["clothesOfChild"],
      "ماكن للأطفال": list["placesOfChild"],
      "رقم الهاتف المبلغ عنها": list["phoneNumberOfReported"],
      "تاريخ العثور على الطفل": list["dateOfFounded"],
      "صورة الطفل": list["imageUrl"],
    };
    Share.share(sharedData.toString());

  }
}
