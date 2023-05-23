import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/previous_reports/previous_reports_view.dart';
import '../all_missing_and_founded_Screen/all_missing_and_foundedview.dart';
class HomeViewModel extends ViewModel {
  int currentIndex = 0;
  final screens = [
    const AllMissingAndFoundedScreen(),
    const PreviousReportsScreen()
  ];
  onPageChanged( index) {
    currentIndex = index;
    notifyListeners();
  }

}

