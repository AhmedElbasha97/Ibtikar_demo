import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/ImagesModel.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Represtories/PersonsRebo.dart';



class ImagesProvider extends ChangeNotifier {
  Profile image;

  PersonRepository _personalDetailsRepository = PersonRepository();

  PersonalDetailsProvider(id,imgPath) {
    print('id:::$id');
    getPersonalDetails(id,imgPath);
  }

  void getPersonalDetails(id,imgPath) {
    _personalDetailsRepository.fetchImages(id).then((newImages) {
      newImages.profiles.map((profie) =>{
        if(profie.filePath == imgPath){
          image = profie
        }
      } );

      print('hi3');
      notifyListeners();
    });
  }
}