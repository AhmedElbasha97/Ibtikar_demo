import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibtkar_demo/Models/PersonalDetailsModel.dart';
import 'package:ibtkar_demo/UI/ImagesScreen/ImageScreen.dart';

class PersonalDetailsWadgets extends StatefulWidget {
  final PersonalDetailsModel PersonalDetails;
  final int index;

  const PersonalDetailsWadgets({Key key, this.PersonalDetails, this.index}) : super(key: key);

  @override
  _PersonalDetailsWadgetsState createState() => _PersonalDetailsWadgetsState();
}

class _PersonalDetailsWadgetsState extends State<PersonalDetailsWadgets> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        GestureDetector(
          onTap:() {
            if(widget.PersonalDetails.profilePath != null) {
              print("hi");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImageScreen(id: widget.PersonalDetails.id,
                        imgPath: widget.PersonalDetails.profilePath,)));
            }else{
              showDialog<void>(
                context: context,

                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('cant Show Image'),
                    content: Text("There's no image to display or download"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ],
                  );
                },
              );
            }
            },
          child: Hero(
            tag: 'imageHero${widget.index}',

             child:CachedNetworkImage(
                imageUrl:
                'https://image.tmdb.org/t/p/w500${widget.PersonalDetails.profilePath}',
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
            '${widget.PersonalDetails.name}',
            style:
            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Text('Date Of Birth: ${widget.PersonalDetails.birthday.day}/${widget.PersonalDetails.birthday.month}/${widget.PersonalDetails.birthday.year}'),
        Text('Gender: ${widget.PersonalDetails.gender}'),
        Text('place Of Birth: ${widget.PersonalDetails.placeOfBirth}'),
        Text('Date Of death: ${widget.PersonalDetails.deathday?? "Doesnt dead yet"}'),



        Text(
          '${widget.PersonalDetails.biography}',
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
