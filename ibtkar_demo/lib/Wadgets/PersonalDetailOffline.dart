import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/PersonsModel.dart';

import 'PersonListWadget.dart';

class PersonalDetailsOfflineWadgets extends StatefulWidget {
  final Result PersonalDetails;
  final int index;
  const PersonalDetailsOfflineWadgets({Key key, this.PersonalDetails, this.index}) : super(key: key);
  @override
  _PersonalDetailsWadgetsState createState() => _PersonalDetailsWadgetsState();
}
class _PersonalDetailsWadgetsState extends State<PersonalDetailsOfflineWadgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Actors'),

        ),
        body:Center(
          child: Column(
            children: [
              Hero(
                tag: 'imageHero${widget.index}',
                child:CachedNetworkImage(
                  imageUrl:
                  'https://image.tmdb.org/t/p/w500${widget.PersonalDetails.profilePath}',
                  imageBuilder: (context, imageProvider) => Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    margin: EdgeInsets.all(20.0),

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '${widget.PersonalDetails.name}',
                  style:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Text('Gender:${decideGender(widget.PersonalDetails.gender)}',),
            ],
          ),
        )

    );

  }
}
