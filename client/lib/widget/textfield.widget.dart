import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {required this.textEditingController,
      required this.hint,
      required this.color,
      super.key});
  final TextEditingController textEditingController;
  final String hint;
  final Color color;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 70,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        color: widget.color,
        child: TextField(
          cursorColor: const Color.fromARGB(255, 127, 99, 252),
          keyboardAppearance: Brightness.dark,
          controller: widget.textEditingController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20.0, top: 5),
            labelText: widget.hint,
            hintText: widget.hint,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
