import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/home/home_view.dart';
import 'package:talaqy/pages/previous_reports/previous_reports_view.dart';
class HomeViewModel extends ViewModel {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const PreviousReportsScreen()
  ];
  onPageChanged( index) {
    currentIndex = index;
    notifyListeners();
  }
}

