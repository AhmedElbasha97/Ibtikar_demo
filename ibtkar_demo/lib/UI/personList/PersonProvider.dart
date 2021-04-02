import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/PersonsModel.dart';
import 'package:ibtkar_demo/Represtories/PersonsRebo.dart';
class PersonListProvider extends ChangeNotifier{
  List<Result> persons;
  int counter = 1;
  PersonRepository _personRepository = PersonRepository();

  PersonListProvider(){
    getPersonsAtFrist();
  }

  void getPersonsAtFrist() {
    _personRepository.fetchPersons(page: counter).then(
            (newPerson){
              if(persons == null) {
                persons = newPerson;
              }else{
                persons = persons + newPerson;
              }
          counter++;
          notifyListeners();
        }
    );
  }
}
