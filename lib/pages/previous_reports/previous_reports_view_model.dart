import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmvvm/pmvvm.dart';
class PreviousReportsViewModel extends ViewModel {
  final  CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  final  CollectionReference addFoundedRef =
  FirebaseFirestore.instance.collection("Founded People");
  QuerySnapshot? data;
}