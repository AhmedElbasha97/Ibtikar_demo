import 'package:ibtkar_demo/Local_Storage/db_helper.dart';
import 'package:ibtkar_demo/Models/ImagesModel.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Models/PersonsModel.dart';
import 'package:ibtkar_demo/Services/PersonServices.dart';
import 'package:connectivity/connectivity.dart';
class PersonRepository{
  PersonsService _personsService = PersonsService();
  Future<List<Result>> fetchPersons({page:1}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    final dbHelper = DbHelper.instance;
    if (connectivityResult == ConnectivityResult.none) {
      List<Map<String, dynamic>> dbMoviesMap = await dbHelper.queryAllRows();
      List<Result> dbMovies =
      dbMoviesMap.map((e) => Result.fromDatabase(e)).toList();
      return dbMovies;
    } else {
      final netPersons = await _personsService.fetchPersons(page: page);
      for (final person in netPersons) {
        dbHelper.insert(person.toMap());
      }
      return netPersons;
    }

    // return _personsService.fetchPersons(page: page);
  }
  Future<PersonalDetailsModel> fetchPersonalDetails(id) {
    return _personsService.fetchPersonalDetails(id);
  }
  Future<ImagesModel> fetchImages(id) {
    return _personsService.fetchImages(id);
  }

}