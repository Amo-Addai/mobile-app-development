import 'package:flutter/material.dart';

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
              }
            });
        })
      });

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
              padding: EdgeInsets.only(
                top: 40
              ),
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(

                  )
                )
              )
            )
          ),
          body: Column(
            children: [
              Position(
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
