import 'package:discord/auth/view/birthday.dart';
import 'package:discord/widget/custombutton.widget.dart';
import 'package:discord/widget/textfield.widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({required this.email, super.key});
  final String email;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff37373e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
            ),
            const Center(
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              height: 20,
            ),
            const Text(
              'WHAT SHOULD EVERYONE CALL YOU?',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
            ),
            Container(
              height: 20,
            ),
            TextFieldWidget(
                textEditingController: displayNameController,
                hint: 'Username',
                color: const Color.fromARGB(255, 24, 24, 24)),
            const SizedBox(height: 16.0),
            const Text(
              'You can always change this later!',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
                textEditingController: passwordController,
                hint: 'Password',
                color: const Color.fromARGB(255, 24, 24, 24)),
            const SizedBox(height: 16.0),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: CustomButtonWidget(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => BirthDayPage(
                                  displayName: displayNameController.text,
                                  password: passwordController.text,
                                  email: widget.email,
                                )));
                  },
                  message: 'Next',
                  color: const Color.fromARGB(255, 127, 99, 252),
                )),
          ],
        ),
      ),
    );
  }
}
