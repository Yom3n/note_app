import 'package:flutter/material.dart';

class NaLoadingIndicator extends StatelessWidget {
  const NaLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
