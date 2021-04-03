import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibtkar_demo/UI/ImagesScreen/ImageProvider.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
class ImageScreen extends StatefulWidget {
  final imgPath;
  final id;
  const ImageScreen({Key key, this.imgPath,this.id})
      : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState(id,imgPath);
}

class _ImageScreenState extends State<ImageScreen> {

  final id;
  final imgPath;
  List<File> _mulitpleFiles = [];

  _ImageScreenState(this.id, this.imgPath);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("download image"),
        actions: [
          IconButton(onPressed: () {
            print("hi imge");
            showDialog<void>(
                context: context,
                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('downoad Image'),
                    content: Text("the image will be on your device localy in download file"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          ImageDownloader.downloadImage(
                              'https://image.tmdb.org/t/p/w500${widget.imgPath}')
                              .catchError((error) {
                            if (error is PlatformException) {
                              var path = "";
                              if (error.code == "404") {
                                print("Not Found Error.");
                              } else if (error.code == "unsupported_file") {
                                print("UnSupported FIle Error.");
                                path = error.details["unsupported_file_path"];
                              }
                            }
                          });
                          Navigator.of(dialogContext)
                              .pop();
                          },
                      ),
                      FlatButton(
                        child: Text('cancel'),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ],
                  );
                }
            );
          }
    , icon: Icon(Icons.arrow_circle_down))
        ],
      ),
      body: ChangeNotifierProvider<ImagesProvider>(
        create: (context) => ImagesProvider(id, imgPath),
        child:
        Consumer<ImagesProvider>(builder: (buildContext, ImagesProvider, _) {
          final image = ImagesProvider.image;
          print(image);
          if (ImagesProvider.image != null) {
            return Container(
                height: image.height.toDouble(),
                width: image.width.toDouble(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${widget.imgPath}'
                    ),
                  ),

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
