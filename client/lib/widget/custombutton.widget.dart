import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget(
      {required this.onPressed,
      required this.message,
      required this.color,
      super.key});
  final Function()? onPressed;
  final String message;
  final Color color;
  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: widget.color,
            child: Text(widget.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                )),
          ),
        ));
  }
}
