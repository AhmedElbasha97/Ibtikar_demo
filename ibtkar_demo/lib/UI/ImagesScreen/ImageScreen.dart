
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
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File _imageFile;
  int _progress = 0;

  List<File> _mulitpleFiles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("download image"),
      ),
      body: ChangeNotifierProvider<ImagesProvider>(
        create: (context) => ImagesProvider(widget.id,widget.imgPath),
        child:
        Consumer<ImagesProvider>(builder: (buildContext, ImagesProvider, _) {
          final image = ImagesProvider.image;
          print(image);
          if (ImagesProvider.image != null) {

            return GestureDetector(
              onTap: (){
                print("hi imge");
                _downloadImage(
                    'https://image.tmdb.org/t/p/w500${widget.imgPath}',
                  destination: AndroidDestinationType.directoryPictures
                    ..inExternalFilesDir()
                    ..subDirectory("sample.gif"),
                );
              },
              child: Container(
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
              ),
            );


          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );

  }

  Future<void> _downloadImage(
      String url, {
        AndroidDestinationType destination,
        bool whenError = false,
        String outputMimeType,
      }) async {
    String fileName;
    String path;
    int size;
    String mimeType;
    try {
      String imageId;

      if (whenError) {
        imageId = await ImageDownloader.downloadImage(url,
            outputMimeType: outputMimeType)
            .catchError((error) {
          if (error is PlatformException) {
            String path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
            setState(() {
              _message = error.toString();
              _path = path ?? '';
            });
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
          return;
        });
      } else {
        if (destination == null) {
          imageId = await ImageDownloader.downloadImage(
            url,
            outputMimeType: outputMimeType,
          );
        } else {
          imageId = await ImageDownloader.downloadImage(
            url,
            destination: destination,
            outputMimeType: outputMimeType,
          );
        }
      }

      if (imageId == null) {
        return;
      }
      fileName = await ImageDownloader.findName(imageId);
      path = await ImageDownloader.findPath(imageId);
      size = await ImageDownloader.findByteSize(imageId);
      mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      setState(() {
        _message = error.message ?? '';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      var location = Platform.isAndroid ? "Directory" : "Photo Library";
      _message = 'Saved as "$fileName" in $location.\n';
      _size = 'size:     $size';
      _mimeType = 'mimeType: $mimeType';
      _path = path ?? '';

      if (!_mimeType.contains("video")) {
        _imageFile = File(path);
      }
      return;
    });
  }
}

