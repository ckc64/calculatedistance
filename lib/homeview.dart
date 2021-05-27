import 'package:flutter/material.dart';
import 'package:project/model/userlocation.dart';
import 'package:provider/provider.dart';
import 'package:project/location.dart';
class HomeView extends StatelessWidget {
  static const String id = 'homeview';
  const HomeView({Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text('Location : Lat${userLocation.latitude},Long${userLocation.longitude}'),
          ),
        ],
      ),
    );
  }
}

