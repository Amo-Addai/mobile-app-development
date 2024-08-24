import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double? imageHeight;
  double? imageWidth;
  List? recognitions;
  CameraImage? imageCamera;
  CameraController? cameraController;
  bool isWorking = false;

  loadModel() async {
    Tflite.close();
    try {
      String response =
        await Tflite
          .loadModel(
            model: 'assets/ai/posenet_mv1_075_float_from_checkpoints.tflite',
            // labels: // * labels not required for pose-estimation (model detects all body-parts for different poses)
          );
      print(response);
    } on PlatformException {
      print('Unable to laod Model');
    }
  }

  initCamera() => (
    cameraController =
      CameraController(
        cameras[0],
        ResolutionPreset.medium
      ),
    cameraController
      .initialize()
      .then((value) => {
        if (!mounted) null,
        setState(() =>
          cameraController
            .startImageStream(
              (imageFromStream) => {
                if (!isWorking) {
                  isWorking = true,
                  imageCamera = imageFromStream,
                  runModelOnStreamFrame()
                }
              }
            )
        )
      })
  );

  runModelOnStreamFrame() async => {
    imageHeight =
      imageCamera.height + 0.0,
    imageWidth =
      imageCamera.width + 0.0,
    recognitions =
      await Tflite
        /*
        .detectObjectOnFrame( // TODO: Or - .runPoseNetOnFrame(..) - for detecting Poses exactly
          bytesList: imageCamera
            .planes.map(
              (plane) => plane.bytes
            ).toList(),
          imageHeight: imageCamera.height,
          imageWidth: imageCamera.width,
          numResultsPerClass: 2,
        ),
        */
        .runPoseNetOnFrame(
          bytesList: imageCamera
              .planes.map(
                  (plane) => plane.bytes
          ).toList(),
          imageHeight: imageCamera.height,
          imageWidth: imageCamera.width,
          numResults: 2,
        ),

    isWorking = false,
    setState(() => imageCamera)
  };

  @override
  initState() => {
    super.initState(),
    initCamera(),
    loadModel()
  };

  @override
  dispose() => {
    super.dispose(),
    cameraController
      .stopImageStream(),
    Tflite.close()
  };

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildrenWidgets = [];

    stackChildrenWidgets
      .add(
        Positioned( // * demonstration (should be put directly into main returned-ui; or dynamically expand the list here)
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height - 100,
          child: Container(
            height: size.height - 100,
            child:
              (
                !cameraController
                  .value
                  .isInitialized
              )
              ? Container(
                // TODO:
              )
              : AspectRatio(
                aspectRatio:
                  cameraController
                    .value.aspectRatio,
                child: CameraPreview(
                  cameraController
                )
              )
          )
        )
      );

    List<Widget> displayKeyPoints(Size screen) {
      // * returns specific data-type; cannot be an (Set<dynamic>) arrow-lambda
      if (
        recognitions != null
        || imageHeight == null
        || imageWidth == null
      ) return [];

      double factorX = screen.width;
      double factorY = imageHeight!; // validated imageHeight != null

      var allLists = <Widget>[]; // * to be returned

      recognitions?.forEach(
          (element) {

            var list =
              element['keypoints']
                .values
                .map<Widget>(
                  (val) => Positioned(
                    left:
                      val['x']
                      * factorX - 6,
                    top:
                      val['y']
                          * factorY - 6,
                    width: 100,
                    height: 20,
                    child: Text(
                      "- ${val['part']}", // Text cannot be const because nullable 'val' might not be constant
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 14
                      )
                    )
                  )
                )
                .toList();

            // now, append all lists
            allLists.addAll(list);
          }
      );
      return allLists;
    }

    if (imageCamera != null) {
      stackChildrenWidgets.addAll( // like so
        displayKeyPoints(size)
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(
            top: 50
          ),
          color: Colors.black,
          child: Stack(
            children: stackChildrenWidgets, // List<Widget>
          )
        )
      )
    );
  }

}
