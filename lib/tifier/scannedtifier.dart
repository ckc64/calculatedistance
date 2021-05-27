import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:project/model/scanned.dart';

class Scannedtifier with ChangeNotifier{
  List<Scanned> _scannedList=[];
  Scanned _currentScanned;
  UnmodifiableListView<Scanned> get scannedList=> UnmodifiableListView(_scannedList);
  Scanned get currentScanned=> _currentScanned;
  set scannedList(List<Scanned>scanned){
    _scannedList = scannedList;
    notifyListeners();
  }
  set current(Scanned scanned){
    _currentScanned =scanned;
    notifyListeners();
  }
}