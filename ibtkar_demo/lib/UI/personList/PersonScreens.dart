import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:ibtkar_demo/UI/PersonDetails/PersonalDetailsScreen.dart';
import 'package:ibtkar_demo/UI/personList/PersonProvider.dart';
import 'package:ibtkar_demo/Wadgets/PersonListWadget.dart';
import 'package:ibtkar_demo/Wadgets/PersonalDetailOffline.dart';
import 'package:provider/provider.dart';



class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Actors'),

        ),
        body: ChangeNotifierProvider<PersonListProvider>(
          create: (context) => PersonListProvider(),
          child: Consumer<PersonListProvider>(
            builder: (buildContext, PersonListProvider, _) {
              print('hi4');

              return (PersonListProvider.persons != null)
                  ? ListView.builder(
                  itemCount: PersonListProvider.persons.length,
                  itemBuilder: (ctx, index) {
                    final person = PersonListProvider.persons[index];
                    if((PersonListProvider.persons.length-2) == index){
                      PersonListProvider.getPersonsAtFrist();
                    }

                    return GestureDetector(
                        child: PersonListWidget(person: person,index: index),
                    onTap: () async{
                      var connectivityResult = await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.none) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            PersonalDetailsOfflineWadgets(PersonalDetails: person,index: index)));
                      }else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(personalDetails: person,
                                  index: index,
                                  id: person.id,)));
                      }
                      },);
                  })
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

}
