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

  void shareStrings(List<String> strings) {
    // Concatenate the strings into a single message
    String message = strings.join('\n');

    // Share the message using the share_plus package
    Share.share(message);
  }
  onPageChanged( index){
    currentIndex=index;
    notifyListeners();
  }

  }




