import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserPicture extends StatefulWidget {
  static const String id = 'userspicture';
  @override
  _UserPictureState createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {

  File ImageFile;

  _openGallery (BuildContext context)async{
   var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      ImageFile = picture;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context)async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      ImageFile = picture;
    });
    Navigator.of(context).pop();
  }
  Future<void> _showDialog(BuildContext context){
    // ignore: missing_return
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Make a Chioce'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text('Gallery'),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              GestureDetector(
                child: Text('Camera'),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }
  Widget _decideImageView(){
    if(Image == null){
      return Text('no Image Selected');
    }else{
      return Image.file(ImageFile,width: 400,height: 400,);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Image Picker'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(onPressed: (){
                _showDialog(context);
              },child: Text('Select Image'),),
            ]
          ),
        ),
      ),
    );
  }
}