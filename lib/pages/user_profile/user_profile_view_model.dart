import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmvvm/pmvvm.dart';
class UserProfileViewModel extends ViewModel {
  final CollectionReference userData =
  FirebaseFirestore.instance.collection("users");



}