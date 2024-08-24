import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? prop;
  String _stateProp1 = '';
  String? _stateProp2;

  meth() {
    _stateProp2 = 'state-value';
    setState(() {
      _stateProp1 = 'state-value';
      _stateProp2;
    });
  }

  @override
  void initState() { // initialize widget's state
    super.initState();

  }

  @override
  void dispose() { // initialize widget
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
