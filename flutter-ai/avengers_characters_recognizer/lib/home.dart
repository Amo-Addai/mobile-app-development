import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<File>? imageFile;
  File? _image;
  String _result = '';
  ImagePicker? imagePicker;

  loadDataModelFiles() async {
    String output =
      await Tflite
        .loadModel(
          model: 'assets/ai/model_unquant.tflite',
          labels: 'assets/ai/labels.txt',
          numThreads: 1,
          isAsset: true,
          useGpuDelegate: false
        );
    print(output);
  }

  doImageClassification() async {
    var recognitions =
      await Tflite
        .runModelOnImage(
          path: _image?.path, // * no fallback image; let it fail if null
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 2,
          threshold: 0.1,
          asynch: true
        );
    print(
      recognitions
        .length
          .toString()
    );
    setState(() => _result = '');
    recognitions.forEach(
        (element) =>
          setState(
            () { // used block-lambda instead
              print( // * void statements cannot be used as arrow-lambda () => (..) args
                  element.toString()
              );
              _result += element['label'];
            }
          )
    );
  }

  selectPhoto() async {
    PickedFile pickedFile =
      await imagePicker
        .getImage(
          source: ImageSource.gallery
        );
    _image = File(pickedFile.path);
    setState(() => (
      _image,
      doImageClassification()
    ));
  }

  capturePhoto() async {
    PickedFile pickedFile =
      await imagePicker
        .getImage(
          source: ImageSource.camera
        );
    _image = File(pickedFile.path);
    setState(() => (
      _image,
      doImageClassification()
    ));
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            children: [

              const SizedBox(
                width: 100
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20
                ),
                child: Stack(
                  children: <Widget>[

                    Center(
                      child: FlatButton(
                        onPressed: selectPhoto,
                        onLongPress: capturePhoto,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            right: 35,
                            left: 18
                          ),
                          child:
                            _image != null
                            ? Image.file(
                              _image!,
                              height: 160,
                              width: 400,
                              fit: BoxFit.cover
                            )
                            : Container(
                              width: 140,
                              height: 190,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black
                              )
                            )
                        )
                      )
                    ),

                    // TODO: Output Text-View

                    const SizedBox(
                      height: 50
                    ),

                    Text(
                      '$_result',
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        backgroundColor: Colors.grey
                      )
                    ),

                  ]
                )
              ),

            ]
          )

        )
      )
    );
  }
}
