import 'package:flutter/material.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 250,
          height: 200,
          color: Colors.black38,
        )
      ],
    );
  }
}
