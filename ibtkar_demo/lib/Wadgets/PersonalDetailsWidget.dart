import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';

class PersonalDetailsWadgets extends StatelessWidget {
  final PersonalDetailsModel PersonalDetails;
  final int index;

  const PersonalDetailsWadgets({Key key, this.PersonalDetails, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        GestureDetector(
          onTap:() {
            print("hi");
          },
          child: Hero(
            tag: 'imageHero$index',

             child:CachedNetworkImage(
                imageUrl:
                'https://image.tmdb.org/t/p/w500${PersonalDetails.profilePath}',
                imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.5,

                decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),

                image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                ),
                ),
                ),
                placeholder: (context, url) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('lib/assets/download.jpeg'),
              ),
            ),
          ),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '${PersonalDetails.name}',
            style:
            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Text('Date Of Birth: ${PersonalDetails.birthday.day}/${PersonalDetails.birthday.month}/${PersonalDetails.birthday.year}'),
        Text('Gender: ${PersonalDetails.gender}'),
        Text('place Of Birth: ${PersonalDetails.placeOfBirth}'),
        Text('Date Of death: ${PersonalDetails.deathday?? "Doesnt dead yet"}'),



        Text(
          '${PersonalDetails.biography}',
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
