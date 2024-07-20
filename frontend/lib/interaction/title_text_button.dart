import 'package:flutter/material.dart';

class TitleTextButton extends StatelessWidget {
  const TitleTextButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => print('back to home'),
        onLongPress: () => print('Easter egg on long press'),
        onHover: (value) => print('onHover $value'),
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: Colors.transparent,
              width: 5,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            // color: Colors.black,
            // foreground: Paint()
            //   ..style = PaintingStyle.stroke
            //   ..strokeWidth = 1
            //   ..color = Colors.blue[800]!,
          ),
        ));
  }
}