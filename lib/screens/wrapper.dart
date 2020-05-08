import 'package:flutter/material.dart';

import 'authenticate/authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either authentication screen or home screen
    return new Container(
      child: Authentication(),
    );
  }
}
