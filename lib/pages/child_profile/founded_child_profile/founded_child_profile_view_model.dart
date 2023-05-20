import 'package:pmvvm/pmvvm.dart';

class FoundedChildProfileViewModel extends ViewModel {
  var docId;
  var list;
  String? fatherPhoneNumber;
  FoundedChildProfileViewModel({required this.docId,required this.list});
  void init() {
    setPhoneNumber();
    super.init();
  }

  setPhoneNumber(){
    fatherPhoneNumber = list["phoneNumberOfReported"];
    notifyListeners();

  }

}




