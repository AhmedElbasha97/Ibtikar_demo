import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/ImagesModel.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Represtories/PersonsRebo.dart';



class ImagesProvider extends ChangeNotifier {
  Profile image;

  PersonRepository _personalDetailsRepository = PersonRepository();

  ImagesProvider(id,imgPath) {
    print('id:::$id');
    getPersonalDetails(id,imgPath);
  }

  void getPersonalDetails(id,imgPath) {
    _personalDetailsRepository.fetchImages(id).then((newImages) {
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