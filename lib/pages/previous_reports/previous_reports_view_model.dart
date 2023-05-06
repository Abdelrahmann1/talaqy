import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmvvm/pmvvm.dart';
class PreviousReportsViewModel extends ViewModel {
  var docId;
  
  final  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");

  }
