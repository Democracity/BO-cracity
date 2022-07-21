import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final IconData? icon;
  final VoidCallback onTap;
  final Color color;

  const Button(this.text,
      {Key? key,
        this.height = double.infinity,
        this.width = double.infinity,
        this.icon,
        required this.onTap, required this.color })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 15,
        color: color,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText2
            ),
          ),
        ),
      ),
    );
  }
}
