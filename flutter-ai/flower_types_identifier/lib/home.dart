import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _loading = true;
  File? _image;
  List? _output;
  final picker = ImagePicker();

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/ai/model_unquant.tflite',
      labels: 'assets/ai/labels.txt'
    );
  }

  detectImage(File image) async {
    var output =
      await Tflite
        .runModelOnImage(
          path: image.path,
          numResults: 2,
          threshold: 0.6,
          imageMean: 127.5,
          imageStd: 127.5
        );
    setState(() => (
      _output = output,
      _loading = false
    ));
  }

  pickImage() async {
    var image =
      await picker
        .getImage(
          source: ImageSource.camera
        );
    if (image == null) return null;
    setState(() =>
      _image = File(image.path)
    );
    detectImage(_image!);
  }

  pickGalleryImage() async {
    var image =
      await picker
        .getImage(
          source: ImageSource.gallery
        );
    if (image == null) return null;
    setState(() =>
      _image = File(image.path)
    );
    detectImage(_image!);
  }

  @override
  void initState() {
    super.initState();
    loadModel()
      .then((value) =>
        setState(() => (
          // TODO:
        ))
      );
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50
            ),
            const Text(
              'Auto-Code',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 40,
                fontFamily: 'Schyler', // Signatra
              )
            ),
            const SizedBox(
              height: 5
            ),
            const Text(
              'Flower Types Identifier App',
              style: TextStyle(
                fontFamily: 'Schyler', // Signatra
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 30
              ),
            ),
            const SizedBox(
              height: 50
            ),
            Center(
              child:
                _loading
                ? Container(
                  width: 350,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/flowers.png'), // TODO: ensure in assets/images/
                      const SizedBox(
                        height: 50
                      ),

                    ]
                  )
                )
                : Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 250,
                        child: Image.file(_image!) // TODO: add a fallback image on image?
                      ),
                      const SizedBox(
                        height: 20
                      ),
                      _output != null
                      ? Text(
                        '${_output?[0]?['label']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        )
                      )
                      : Container(),
                      const SizedBox(
                        height: 10
                      ),

                    ],
                  )
                )
            ),
            Container(
              width:
                MediaQuery
                  .of(context)
                  .size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox.fromSize(
                    size: const Size(100, 100),
                    child: ClipOval(
                      child: Material(
                        color: Colors.orange,
                        child: InkWell(
                          // TODO: Camera Button
                          onTap: pickImage,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.black
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                                )
                              ),

                            ]
                          )
                        )

                      )
                    )
                  ),

                  SizedBox.fromSize(
                      size: const Size(100, 100),
                      child: ClipOval(
                          child: Material(
                              color: Colors.orange,
                              child: InkWell(
                                // TODO: Gallery Button
                                onTap: pickGalleryImage,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.browse_gallery,
                                      color: Colors.black
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black
                                      )
                                    ),

                                  ],
                                )
                              )

                          )
                      )
                  ),

                ]
              )
            ),

          ]
        )
      )
    );
  }
}
