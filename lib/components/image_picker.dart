import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:nunta_app/constants.dart';

class ImagePicked extends StatefulWidget {
  @override
  _ImagePickedState createState() => _ImagePickedState();
}

class _ImagePickedState extends State<ImagePicked> {
  
  File _pickedImage;
  final picker = ImagePicker();

  Future getImage() async {
    
    
    final pickedImageFile = await picker.getImage(source: ImageSource.gallery);
    
    setState(() {
      //here make casting for pickedImageFile because they have different data type
      _pickedImage = File(pickedImageFile.path) ;
    });
  }
  // final String endPoint = "http://myscolla.com/nunta/public/api/";
  // void _upload(File file) async {
  //   String fileName = file.path.split('/').last;
  //   print(fileName);

  //   FormData data = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(
  //       file.path,
  //       filename: fileName,
  //     ),
  //   });

  //   Dio dio = new Dio();

  //   dio.post(endPoint, data: data).then((response) {
  //     var jsonResponse = jsonDecode(response.toString());
  //     var testData = jsonResponse['histogram_counts'].cast<double>();
  //     var averageGrindSize = jsonResponse['average_particle_size'];
  //   }).catchError((error) => print(error));
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: kTitleColor,
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage)
              : null,
          // child: _pickedImage !=null? Image.file(_pickedImage):null,
        ),
         
        Positioned(
          top: 105,
          left: 15,
          child: TextButton.icon(onPressed: getImage,autofocus: true, icon: Icon(Icons.camera_alt_rounded,color: kWordColor,), label: Text("Take photo",style: TextStyle(color: kWordColor),)))
      ],
    );
  }
}