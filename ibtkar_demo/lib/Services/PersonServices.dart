import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ibtkar_demo/Models/ImagesModel.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/Models/PersonsModel.dart';

class PersonsService {
  Future<List<Result>> fetchPersons({int page = 1}) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/popular?api_key=c949a0e09b06fbc87cacfbef4c504963&language=en-US&page=${page}'));
    if (response.statusCode == 200) {
      var per=List<Result>.from((json.decode(response.body)["results"] as List)
          .map((e) => Result.fromJson((e)))).toList();
      print(per[1].gender);
      return List<Result>.from((json.decode(response.body)["results"] as List)
          .map((e) => Result.fromJson((e)))).toList();
    } else {
      throw Exception('FAILED TO LOAD Movies');
    }
  }


  Future<PersonalDetailsModel> fetchPersonalDetails(int id) async {
    var response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/person/$id?api_key=c949a0e09b06fbc87cacfbef4c504963&language=en-US'));
    if (response.statusCode == 200) {
      var person = personalDetailsModelFromJson(response.body);
      print("movie${person.name}");
      return personalDetailsModelFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD THE MOVIE');
    }
  }
  Future<ImagesModel> fetchImages(int id) async {
    var response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/person/$id/images?api_key=c949a0e09b06fbc87cacfbef4c504963'));
    if (response.statusCode == 200) {
      var person = imagesModelFromJson(response.body);
      print("movie${person.id}");
      return imagesModelFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD THE MOVIE');
    }
  }
}
