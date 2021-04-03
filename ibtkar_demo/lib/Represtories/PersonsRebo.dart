
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Models/PersonsModel.dart';
import 'package:ibtkar_demo/Services/PersonServices.dart';



class PersonRepository{
  PersonsService _personsService = PersonsService();

  Future<List<Result>> fetchPersons({page:1}) async {
    return _personsService.fetchPersons(page: page);
  }
  Future<PersonalDetailsModel> fetchPersonalDetails(id) {

    return _personsService.fetchPersonalDetails(id);
  }


}