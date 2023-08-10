import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';



class UploadAadharProvider extends ChangeNotifier {
  String _message = "";
  bool _status = false;
  String get message => _message;
  bool get status => _status;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  void clear() {
    _message = "";
  }

  Future addAadhar({
    File? aadharFront,
    File? aadharBack,
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    _status = true;
    notifyListeners();

    CollectionReference userCollection = _firestore.collection("Users");
    String aadharFrontPath = "";
    String aadharBackPath = "";
    try {
      _message = "Uploading Image";
      notifyListeners();

      final aadharFrontName = aadharFront!.path.split('/').last;
      final aadharBackName = aadharBack!.path.split('/').last;
      //front
      await _storage
          .ref()
          .child("$uid/aadhar/$aadharFrontName")
          .putFile(aadharFront)
          .whenComplete(() async {
        await _storage
            .ref()
            .child("$uid/aadhar/$aadharFrontName")
            .getDownloadURL()
            .then((value) {
          aadharFrontPath = value;
        });
      });
      //back
      await _storage
          .ref()
          .child("$uid/aadhar/$aadharBackName")
          .putFile(aadharBack)
          .whenComplete(() async {
        await _storage
            .ref()
            .child("$uid/aadhar/$aadharBackName")
            .getDownloadURL()
            .then((value) {
          aadharBackPath = value;
        });

        final data = {
          'isverified': true,
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'uid': uid,
          'aadharfront': aadharFrontPath,
          'aadharback': aadharBackPath,
          'accounttype': 'manager' 
        };

        await userCollection.doc(uid).set(data);
        _status = false;
        _message = 'Successful';
      });
    } on FirebaseException catch (e) {
      _status = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (_) {
      _status = false;
      _message = "Internet Required";
      notifyListeners();
    } catch (e) {
      _status = false;
      _message = "Try Again";
      notifyListeners();
    }
  }
}
