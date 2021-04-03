import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:ibtkar_demo/UI/PersonDetails/PersonalDetailsScreen.dart';
import 'package:ibtkar_demo/UI/personList/PersonProvider.dart';
import 'package:ibtkar_demo/Wadgets/PersonListWadget.dart';
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
          title: Text('Movies'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                children: [

                  Icon(Icons.star_rate),
                ],
              ),
            )
          ],
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
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailScreen(personalDetails: person,index: index,id: person.id,)));
                    },);
                  })
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
  //
  // alreadySaved(post)  {if (_saved != null){ return   _saved.contains(post.title);}else{return false;}}
}
// Future decideScreenToShow(context,id,index,post) async{
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.none) {
//     Navigator.of(context).push(MaterialPageRoute(
//
//         builder: (context) => DetailScreen2(movie: post,isFavorite: false,)));
//
//   }else{
//     Navigator.of(context).push(MaterialPageRoute(
//
//         builder: (context) => DetailScreen(
//             id: post.id,
//             index: index,
//             post: post)));
//   }
// }
