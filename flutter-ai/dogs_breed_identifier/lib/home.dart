import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isWorking = false;
  String _result = '';
  CameraController? cameraController;
  CameraImage imageCamera;

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/ai/model.tflite',
      labels: 'assets/ai/labels.txt'
    );
  }

  initCamera() {
    cameraController =
        CameraController(
          cameras[0],
          ResolutionPreset.medium
        );
    cameraController
      .initialize()
      .then((value) => {
        if (!mounted) null,
        setState(
          () =>
          cameraController
            .startImageStream(
              (imageFromStream) => {
                if (!isWorking) {
                  isWorking = true,
                  imageCamera = imageFromStream,
                  runModelOnStreamFrames()
                }
              }
            )
        )
      });
  }

  runModelOnStreamFrames() async {
    if (imageCamera != null) {
      var recognitions =
        await Tflite.runModelOnFrame(
          bytesList:
            imageCamera
              .planes
              .map((plane) => plane.bytes)
              .toList(),
          imageHeight: imageCamera.height,
          imageWidth: imageCamera.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
        );
      _result = "";
      recognitions.forEach(
        (response) =>
          _result +=
            response['label']
            + (
              response['confidence']
                as double
            )
            .toStringAsFixed(2)
            + "\n\n"
      );
      setState(() => _result);
      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'),
                fit: BoxFit.fill
              )
            ),
            child: Column(
              children: [

                Stack(
                  children: [

                    Center(
                      child: Container(
                        height: 320,
                        width: 360,
                        child: Image.asset("assets/images/frame.jpg")
                      )
                    ),

                    Center(
                      child: FlatButton(
                        onPressed: () => initCamera(),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 35
                          ),
                          height: 270,
                          width: 360,
                          child:
                            imageCamera == null
                            ? Container(
                              height: 270,
                              width: 360,
                              child: const Icon(
                                Icons.photo_camera_front,
                                color: Colors.blueAccent,
                                size: 40
                              )
                            )
                            : AspectRatio(
                              aspectRatio:
                                cameraController
                                  .value
                                    .aspectRatio,
                              child: CameraPreview(cameraController)
                            )
                        )
                      )
                    ),

                  ]
                ),

                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 55
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _result,
                        style: const TextStyle(
                          backgroundColor: Colors.white54,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )
                    )
                  )
                ),

              ]
            )
          )
        )
      )
    );
  }
}
