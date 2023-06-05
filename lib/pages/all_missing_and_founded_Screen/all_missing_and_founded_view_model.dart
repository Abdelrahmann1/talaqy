import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/home/home_view.dart';
import 'package:talaqy/pages/previous_reports/previous_reports_view.dart';
class AllMissingAndFoundedViewModel extends ViewModel {
  int currentIndex = 0;
  QuerySnapshot? data;
  final CollectionReference addMissingRef =
      FirebaseFirestore.instance.collection("Missing People");
  final CollectionReference addFoundedRef =
      FirebaseFirestore.instance.collection("Founded People");
  final CollectionReference userData =
  FirebaseFirestore.instance.collection("users");

  final screens = [const HomeScreen(), const PreviousReportsScreen()];
  onPageChanged(index) {
    currentIndex = index;
    notifyListeners();
  }


  List<DocumentSnapshot> dataList = [];
  bool isFetchingData = false;
  @override
  void init() {
    super.init();
    fetchData();
  }

  Future<void> fetchData() async {
    isFetchingData = true;
    notifyListeners();
  }

  Future<void> refreshData() async {
    await fetchData();
  }

  setRefresh() {
    dataList = data!.docs;
    isFetchingData = false;
  }
}
