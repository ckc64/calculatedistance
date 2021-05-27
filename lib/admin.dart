import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/notify.dart';

class Admin extends StatefulWidget {
  static const String id = 'admin';
  final String admin;
  final String password;
  Admin(this.admin, this.password);
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController _searchController = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getUsersPastTripsStreamSnapshots();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var title =
            Notify.fromSnapshot(tripSnapshot).now.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    // ignore: await_only_futures
    //var uid = await FirebaseAuth.instance.currentUser.uid;

    var data =
        await FirebaseFirestore.instance.collection('notifyReport').get();
    setState(() {
      _allResults = data.docs;
      print(data.docs);
    });
    searchResultsList();
    return "complete";
  }

   Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        var curr = currentDate.toString().split(" ");
        _searchController.text = curr[0];
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[
            Text("List Of Establishment", style: TextStyle(fontSize: 20)),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                enabled: false,
              ),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            //   child: Text(
                
            //     currentDate.toString().replaceAll('00:00:00.000', "")
            //   ),
            // ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            ElevatedButton(
              onPressed: () => _searchController.clear(),
              child: Text('Clear Date'),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildNotifyCard(context, _resultsList[index]),
            )),
          ],
        ),
      )),
    );
  }
}

Widget buildNotifyCard(BuildContext context, DocumentSnapshot document) {
  final n = Notify.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 40),
                child: Row(children: <Widget>[
                  Text(
                    n.establishment1,
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 40),
                child: Row(children: <Widget>[
                  Text(n.now),
                  Spacer(),
                ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
