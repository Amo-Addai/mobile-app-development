import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'main.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CameraImage imageCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result = "";

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/ai/model_unquant.tflite",
      labels: 'assets/ai/labels.txt'
    );
  }

  initCamera() {
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium
    );

    cameraController
      .initialize()
      .then((value) {
        if (!mounted) return;
        setState(() {
          cameraController
            .startImageStream((imageFromStream) => {
              if (!isWorking) {
                isWorking = true,
                imageCamera = imageFromStream,
                runModelOnFrame(),
              }
            });
        });
      });

  }

  runModelOnFrame() async {
    if (imageCamera != null) {
      var recognitions =
          await Tflite
            .runModelOnFrame(
              bytesList:
                imageCamera
                  .planes
                  .map((plane) {
                    return plane.bytes;
                  })
                  .toList(),
              imageHeight: imageCamera.height,
              imageWidth: imageCamera.width,
              imageMean: 127.5,
              imageStd: 127.5,
              rotation: 90,
              numResults: 1,
              threshold: 0.1,
              asynch: true,
          );
      result = "";
      recognitions
        .forEach((response) {
          result +=
              response["label"]
              + "\n";
        });
      setState(() => result);
      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {

    Size bodySize =
        MediaQuery.of(context)
          .size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Padding(
              padding: const EdgeInsets.only(
                top: 40
              ),
              child: Center(
                child: Text(
                  result,
                  style: const TextStyle(
                    backgroundColor: Colors.black54,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                )
              )
            )
          ),
          body: Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: bodySize.width,
                height: bodySize.height - 100, // todo: ?
                child: Container(
                  height: bodySize.height - 100,
                  child:
                    !cameraController
                        .value
                        .initialized
                    ? Container(
                      // TODO: 
                    )
                    : AspectRatio(
                      aspectRatio:
                      cameraController
                      .value
                      .aspectRatio,
                      child: CameraPreview(
                        cameraController
                      )
                    ),
                  )
              ),

            ]
          )
        )
      )
    );
  }
}
