import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x004242),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        children: <Widget>[
          const SizedBox(
            height: 50
          ),
          const Text(
              'Auto-Code',
              style: TextStyle(
                color: Color(0x7D9E9E),
                fontSize: 20
              ),
          ),
          const SizedBox(
            height: 5
          ),
          const Text(
            'Cats and Dogs Detector App',
            style: TextStyle(
              color: Color(0x7D9E9E),
              fontWeight: FontWeight.w500,
              fontSize: 30
            )
          ),
          const SizedBox(
            height: 50
          ),
          Center(
            child: _loading
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

                )
          )
        ]
      )
    );
  }
}
