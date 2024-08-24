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
  File _image;
  List? _output;
  final picker = ImagePicker();

  /* * cannot work with custom set-getters this way
  image() { return this._image; }
  image(File image) { // * : The name 'image' is already defined (no method-definition overrides)
    if (image != null)
      this._image = image;
  }
  */

  @override
  void initState() {
    super.initState();
    loadModel()
      .then((value) {
          setState(() {
            // TODO: 
          });
      });
  }

  detectImage(File image) async {
    var output =
      await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5
      );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/ai/model_unquant.tflite',
      labels: 'assets/ai/labels.txt'
    );
  }

  pickImage() async {
    var image =
        await picker.getImage(
          source: ImageSource.camera
        );
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
  }

  pickGalleryImage() async {
    var image =
        await picker.getImage(
          source: ImageSource.gallery
        );
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
  }

  // TODO: Or ..
  pickImg(bool gallery) async { // todo: = false
    var img =
      await picker.getImage(
        source:
          gallery
          ? ImageSource.gallery
          : ImageSource.camera
      );
    if (img == null) return null;

    setState(() {
      _image = File(img.path);
    });

    detectImage(_image);
  }

  @override
  void dispose() {
    super.dispose();

    // TODO:

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
                  color: Colors.white,
                  fontSize: 20
                ),
            ),
            const SizedBox(
              height: 5
            ),
            const Text(
              'Cats and Dogs Detector App',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 30
              )
            ),
            const SizedBox(
              height: 50
            ),
            Center(
              child:
                _loading
                ? Container(
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/cat_dog_icon.png'),
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
                        child: Image.file(_image),
                      ),
                      const SizedBox(
                        height: 20
                      ),
                      ( // TODO: Can do away with containing ()s, even in this <Widget>[] list
                        _output != null
                            ? Text(
                            '${_output?[0]['label']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            )
                        )
                            : Container(
                          // TODO:
                        )
                      ),
                      const SizedBox(
                        height: 10
                      )
                    ]
                  )
                ),
            ),
            Container(
              width:
                MediaQuery.of(context)
                  .size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width:
                        MediaQuery.of(context)
                          .size.width - 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 18
                      ),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: const Text(
                        'Capture a Photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        )
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 5
                  ),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImage();
                    },
                    child: Container(
                        width:
                        MediaQuery.of(context)
                            .size.width - 250,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 18
                        ),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: const Text(
                            'Select a photo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            )
                        )
                    ),
                  ),
                ]
              )
            )
          ]
        )
      )
    );
  }
}
