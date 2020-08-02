import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {

  static final String id = 'details_screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
      ),
    );
  }
}
