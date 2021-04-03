import 'package:flutter/material.dart';

import 'package:ibtkar_demo/Models/PersonsModel.dart';
import 'package:ibtkar_demo/UI/PersonDetails/PersonalDetailsProvider.dart';
import 'package:ibtkar_demo/Wadgets/PersonalDetailsWidget.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final id;
  final index;
  final Result personalDetails;
  const DetailScreen({Key key, this.id, this.index, this.personalDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personalDetails.name),
      ),
      body: ChangeNotifierProvider<PersonalDetailsProvider>(
        create: (context) => PersonalDetailsProvider(id),
        child:
        Consumer<PersonalDetailsProvider>(builder: (buildContext, PersonalDetailsProvider, _) {
          final personalDetails = PersonalDetailsProvider.personalDetails;
          final images =PersonalDetailsProvider.images;
          if (PersonalDetailsProvider.personalDetails != null) {

            return SingleChildScrollView(
              child: Center(
                child: PersonalDetailsWadgets(PersonalDetails: personalDetails,index: index,images: images,),

              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}