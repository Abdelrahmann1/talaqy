import 'package:carousel_slider/carousel_slider.dart';
import 'package:pmvvm/pmvvm.dart';

class FoundedChildProfileViewModel extends ViewModel {
  var docId;
  var list;
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
}
