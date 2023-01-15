import 'package:flutter/material.dart';

///Base page scaffold
class NaPage extends StatelessWidget {
  final String title;
  final Widget body;
  final FloatingActionButton? fab;

  const NaPage({
    Key? key,
    required this.title,
    required this.body,
    this.fab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: body),
      floatingActionButton: fab,
    );
  }
}
