import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<File>? imageFile;
  File _image;
  String _result = '';
  ImagePicker imagePicker;

  selectPhoto() async {
    PickedFile pickedFile =
      await imagePicker
        .getImage(
          source: ImageSource.gallery
        );
    _image = File(pickedFile.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhoto() async {
    PickedFile pickedFile =
        await imagePicker.getImage(
          source: ImageSource.camera
        );
    _image = File(pickedFile.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  loadDataModelFiles() async {
    String output =
        await Tflite.loadModel(
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
        await Tflite.runModelOnImage(
          path: _image.path,
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
    setState(() {
      _result = "";
    });
    recognitions
      .forEach(
        (element) => {
          print(element.toString()),
          setState(
            () => _result += element['label']
          )
        }
      );
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
                  top: 40
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
                              _image,
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

                  ]
                )
              ),
              const SizedBox(height: 160),
              Container(
                margin: const EdgeInsets.only(
                  top: 20
                ),
                child: Text(
                  '$_result',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Schyler', // Brand Bold
                    fontSize: 35,
                    color: Colors.blueAccent,
                    backgroundColor: Colors.white60
                  )
                )
              ),

            ]
          ),
        )
      )
    );
  }
}
