import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SearchBarProvider extends ChangeNotifier{

  final CollectionReference addMissingRef =
  FirebaseFirestore.instance.collection("Missing People");
  final CollectionReference addFoundedRef =
  FirebaseFirestore.instance.collection("Founded People");

}