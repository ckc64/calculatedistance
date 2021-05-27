import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/autheticate/register.dart';
import 'package:project/signup.dart';
import 'package:project/tifier/scannedtifier.dart';
import 'package:project/scanner.dart';
import 'package:provider/provider.dart';
import 'package:project/model/scanned.dart';
// String title;
// ChangeNotifierProvider(
// create: (context) => Scannedtifier(),
// );
// void main() => runApp(MultiProvider(providers: [
//   ChangeNotifierProvider(
//     create: (context) => Scannedtifier(),
//   ),
// ],child: ViewTest(title,)
// ));

class ViewTest extends StatefulWidget {
  static const String id = 'test';
  final String username;
  ViewTest(this.username,);
  @override
  _ViewTestState createState() => _ViewTestState();
}

class _ViewTestState extends State<ViewTest> {
  String firstname;
  // getScanned(Scannedtifier scannedtifier)async{
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(widget.username).get();
  //   List<Scanned> _scannedList=[];
  //   snapshot.docs.forEach((docx) {
  //     Scanned scanned=Scanned.fromMap(docx.data());
  //     _scannedList.add(scanned);
  //   });
  //   scannedtifier.scannedList = _scannedList;
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getOtherUserCoord();
    // Scannedtifier scannedtifier = Provider.of<Scannedtifier>(context, listen: false);
    // getScanned( scannedtifier);
  }
  @override
  Widget build(BuildContext context) {
    //Scannedtifier scannedtifier = Provider.of<Scannedtifier>(context);
    return Scaffold(
      backgroundColor:Colors.blueGrey[700] ,
      appBar: AppBar(
        title: Text('History'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        actions: [

        ],
      ),
      // body: ListView.separated(
      //   itemBuilder: (BuildContext context ,int index){
      //     return ListTile(
      //       title: Text(scannedtifier.scannedList[index].firstname),
      //       subtitle: Text(scannedtifier.scannedList[index].address),
      //     );
      //   } ,
      //   itemCount: scannedtifier.scannedList.length, separatorBuilder: (BuildContext context, int index) {
      //     return Divider(
      //       color: Colors.black,
      //     );
      // },
      // ),
      body: StreamBuilder(
          stream :FirebaseFirestore.instance.collection(widget.username).snapshots(),
          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return Center(child: Text('no value'));
            }
            return ListView(
              children: snapshot.data.docs.map((docx) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blueGrey[800],
                      child :Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // Text(docx['lastname'],style: TextStyle(color: Colors.white),),
                              FlatButton(onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                 Register.id,
                                );
                              },child: Text(docx['firstname'],style: TextStyle(color: Colors.white),)),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blueGrey[800],
                      child :Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                         Text(docx['lastname'],style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),

                    Container(
                      width: 200,
                      height: 100,
                      color: Colors.deepOrange,
                      child :Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(docx['now'],style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),

                  ],
                );
              }).toList(),
            );
          }
      ),

    );
  }

}

