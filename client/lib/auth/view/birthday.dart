// ignore_for_file: use_build_context_synchronously

import 'package:discord/model/user.model.dart';
import 'package:discord/widget/custombutton.widget.dart';
import 'package:discord/widget/textfield.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../pages/profile/profile.dart';
import '../bloc/export.bloc.dart';
import 'dart:convert';

class BirthDayPage extends StatefulWidget {
  const BirthDayPage(
      {required this.password,
      required this.email,
      required this.displayName,
      super.key});
  final String password;
  final String email;
  final String displayName;
  @override
  State<BirthDayPage> createState() => _BirthDayPageState();
}

class _BirthDayPageState extends State<BirthDayPage> {
  final TextEditingController birthdayController = TextEditingController();

  void _signUp(BuildContext context) async {
    const String apiUrl = 'http://localhost:3000/graphql';
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> data = <String, dynamic>{
      'query': '''
      mutation CreateUser(\$email: String!, \$password: String!, \$displayName: String!, \$birthday: String!) {
        createUser(email: \$email, password: \$password, displayName: \$displayName, birthday: \$birthday) {
          _id
          email
          displayName
          createdAt
          profilePic
          status
          username
          birthday
        }
      }
    ''',
      'variables': <String, String>{
        'email': widget.email,
        'password': widget.password,
        'displayName': widget.displayName,
        'birthday': birthdayController.text,
      },
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        final User user = User(
          id: responseData['data']['createUser']['_id'],
          email: responseData['data']['createUser']['email'],
          username: responseData['data']['createUser']['username'],
          displayName: responseData['data']['createUser']['displayName'],
          birthday: responseData['data']['createUser']['birthday'],
          createdAt: responseData['data']['signIn']['createdAt'],
          profilePic: responseData['data']['signIn']['profilePic'],
          status: responseData['data']['signIn']['status'],
        );
        BlocProvider.of<AuthBloc>(context).add(UserLoggedIn(user));
        Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => ProfilePage(
                      userData: user,
                    )));
      } else {
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  bool isChecked = false;
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
                      'Enter your birthday',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  TextFieldWidget(
                    textEditingController: birthdayController,
                    color: const Color.fromARGB(255, 24, 24, 24),
                    hint: 'Date of Birth',
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          height: 10,
                          width: 20,
                          child: Checkbox(
                              value: isChecked,
                              onChanged: (bool? test) {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              })),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "I have read and agree to Discord's Terms\nof Services and Privacy policy",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      child: CustomButtonWidget(
                        onPressed: () {
                          isChecked ? _signUp(context) : null;
                        },
                        message: 'Next',
                        color: const Color.fromARGB(255, 127, 99, 252),
                      )),
                ])));
  }
}
