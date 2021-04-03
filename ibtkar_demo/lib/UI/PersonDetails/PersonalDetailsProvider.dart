import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/ImagesModel.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Represtories/PersonsRebo.dart';



class PersonalDetailsProvider extends ChangeNotifier {
  PersonalDetailsModel personalDetails;
  ImagesModel images;
  PersonRepository _personalDetailsRepository = PersonRepository();

  PersonalDetailsProvider(id) {

    getPersonalDetails(id);
  }

  void getPersonalDetails(id) {
    _personalDetailsRepository.fetchPersonalDetails(id).then((newPersonalDetails) {
      personalDetails = newPersonalDetails;
      _personalDetailsRepository.fetchImages(id).then((newImages) {
        images = newImages;
        notifyListeners();
      });
    });
  }
}