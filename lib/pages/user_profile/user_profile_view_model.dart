import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmvvm/pmvvm.dart';
class UserProfileViewModel extends ViewModel {
  final CollectionReference userData =
  FirebaseFirestore.instance.collection("users");
  bool isExpanded = true;
  bool isExpanded2 = true;
  String TapToExpandIt = 'Tap to Expand it';
  String Sentence = 'Widgets that have global keys reparent their subtrees when'
      ' location the tree.';
  setExpanded1(){
    isExpanded = !isExpanded;
    notifyListeners();

  }
  setExpanded2(){
    isExpanded2 = !isExpanded2;
    notifyListeners();

  }
}