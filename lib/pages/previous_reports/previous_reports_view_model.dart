import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmvvm/pmvvm.dart';
class PreviousReportsViewModel extends ViewModel {
  final  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  final  CollectionReference addFoundedRef =
  FirebaseFirestore.instance.collection("Founded People");
  QuerySnapshot? data;
  List<DocumentSnapshot> dataList = [];
  bool isFetchingData = false;
  @override
  void init() {
    super.init();
    fetchData();
    notifyListeners();
  }
  Future<void> fetchData() async {
    isFetchingData = true;
    notifyListeners();
  }
  Future<void> refreshData() async {
    await fetchData();
  }
  setRefresh(){
    dataList = data!.docs;
    isFetchingData = false;
  }
}