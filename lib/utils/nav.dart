import 'package:flutter/material.dart';

Future rotas(BuildContext context, Widget page, {bool replace = false}) {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}
