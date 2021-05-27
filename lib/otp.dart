import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Otp extends StatefulWidget {
  final String phone;
  Otp(this.phone);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  String verification;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text('Verify+1-${widget.phone}',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            child: PinPut(
            fieldsCount: 5,
            onSubmit: (String pin) async {
              try{
                await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider
                    .credential(verificationId: verification, smsCode: pin))
                    .then((value) async{
                  if(value.user !=null){
                    print('pass to home');
                  }
                });
              }catch(e){
                FocusScope.of(context).unfocus();
                scaffold.currentState.showSnackBar(SnackBar(content: Text('invalid OTP')));
              }
            },
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(20.0),
              ),
            selectedFieldDecoration: _pinPutDecoration,
            followingFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
            color: Colors.deepPurpleAccent.withOpacity(.5),
            ),
            ),
            ),
          ),
          const SizedBox(height: 30.0),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () => _pinPutFocusNode.requestFocus(),
                child: const Text('Focus'),
              ),
              FlatButton(
                onPressed: () => _pinPutFocusNode.unfocus(),
                child: const Text('Unfocus'),
              ),
              FlatButton(
                onPressed: () => _pinPutController.text = '',
                child: const Text('Clear All'),
              ),
            ],
          )
        ],
      ),

    );
  }
  verifyPhone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+1${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential)async{
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value)async {
            if (value.user != null){
              print('user logged in');

            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationID,int resendToken){
          setState(() {
            verification = verificationID;
          });

        },
        codeAutoRetrievalTimeout: (String verificationID){
          setState(() {
            verification = verificationID;
          });
        },timeout: Duration(seconds: 60));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
  }
}
