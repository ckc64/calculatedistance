import 'package:flutter/material.dart';
import 'package:project/authenticate.dart';
import 'package:project/model/user.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';
import 'package:project/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    // print(user);
    // return Authenticate();
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
