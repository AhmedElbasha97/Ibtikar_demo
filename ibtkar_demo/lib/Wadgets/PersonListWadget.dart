import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/PersonsModel.dart';
import 'package:ibtkar_demo/generated/assets.dart';

class PersonListWidget extends StatelessWidget {
  final Result person;
  final int index;
  const PersonListWidget({Key key, this.person, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 'imageHero$index',
            child:CachedNetworkImage(
              imageUrl:
              'https://image.tmdb.org/t/p/w500${person.profilePath}',
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width / 3.875,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),

                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),

                ),
              ),
              placeholder: (context, url) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset('lib/assets/iPhone X, XS, 11 Pro – 1.png'),
            ),
          ),
          Column(
            children: [
              SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  person.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                child: Text(

                    'Poplarety: ${person.popularity.toString()}',
                    textAlign: TextAlign.left),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,

                child: Text(
                  '${person.knownForDepartment.toString()}',
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}