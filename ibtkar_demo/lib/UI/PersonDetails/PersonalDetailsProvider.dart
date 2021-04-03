import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Represtories/PersonsRebo.dart';



class PersonalDetailsProvider extends ChangeNotifier {
  PersonalDetailsModel personalDetails;

  PersonRepository _personalDetailsRepository = PersonRepository();

  PersonalDetailsProvider(id) {
    print('id:::$id');
    getPersonalDetails(id);
  }

  void getPersonalDetails(id) {
    _personalDetailsRepository.fetchPersonalDetails(id).then((newPersonalDetails) {
      personalDetails = newPersonalDetails;
      print('hi3');
      notifyListeners();
    });
  }
}