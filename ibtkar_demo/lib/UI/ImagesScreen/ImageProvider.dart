import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/ImagesModel.dart';
import 'package:ibtkar_demo/Represtories/PersonsRebo.dart';



class ImagesProvider extends ChangeNotifier {
  Profile image;

  PersonRepository _imagesrepo = PersonRepository();

  ImagesProvider(id,imgPath) {
    print('id:::$id');
    GetImages(id,imgPath);
  }

  void GetImages(id,imgPath) {
    _imagesrepo.fetchImages(id).then((newImages) {
      newImages.profiles.forEach((prof) =>{
        if(prof.filePath == imgPath){
          image = prof
        }
      } );

      print('hi3');
      notifyListeners();
    });
  }
}