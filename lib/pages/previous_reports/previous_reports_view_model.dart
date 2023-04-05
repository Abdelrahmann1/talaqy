import 'package:pmvvm/pmvvm.dart';


class PreviousReportsViewModel extends ViewModel {
  int page = 0;
  onPageIndex(int index){
    page=index;
    notifyListeners();
  }
}
