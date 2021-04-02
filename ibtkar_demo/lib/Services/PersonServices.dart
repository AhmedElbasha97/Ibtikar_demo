import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ibtkar_demo/Models/PersonsModel.dart';

class PersonsService{
  Future<List<Result>> fetchPersons({int page = 1}) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/popular?api_key=c949a0e09b06fbc87cacfbef4c504963&language=en-US&page=${page}'));
    if (response.statusCode == 200) {

      print(List<Result>.from((json.decode(response.body)["results"] as List)
          .map((e) => Result.fromJson((e)))).toList());
      return List<Result>.from((json.decode(response.body)["results"] as List)
          .map((e) => Result.fromJson((e)))).toList();
    } else {
      throw Exception('FAILED TO LOAD Movies');
    }
  }


  Future<P> fetchMovie(int id) async {
    var response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US'));
    if (response.statusCode == 200) {
      var Movie =movieDetailsModelFromJson(response.body);
      print("movie${Movie.title}");
      return movieDetailsModelFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD THE MOVIE');
    }
}
