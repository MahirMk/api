import 'package:flutter/material.dart';

import 'models/Animal.dart';

class AnimalDetailsWithModel extends StatefulWidget {

  Animal obj;

  AnimalDetailsWithModel({this.obj});

  @override
  State<AnimalDetailsWithModel> createState() => _AnimalDetailsWithModelState();
}

class _AnimalDetailsWithModelState extends State<AnimalDetailsWithModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Text(widget.obj.name),
          Text(widget.obj.latinName),
        ],
      ),
    );
  }
}
