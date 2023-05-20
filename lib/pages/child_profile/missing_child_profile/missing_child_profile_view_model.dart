import 'package:carousel_slider/carousel_controller.dart';
import 'package:pmvvm/pmvvm.dart';

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
  onPageChanged( index){
    currentIndex=index;
    notifyListeners();
  }

  }




