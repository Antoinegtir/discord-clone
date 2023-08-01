import 'package:discord/auth/view/login.dart';
import 'package:discord/auth/view/name.dart';
import 'package:discord/widget/custombutton.widget.dart';
import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff37373e),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(fit: StackFit.expand, children: <Widget>[
              Image.asset(
                'assets/discord.png',
                height: MediaQuery.of(context).size.height,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    'Welcome to Discord',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    'Join over 100 million people who use Discord to talk\nwith communaties and friends',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: CustomButtonWidget(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) =>
                                        EmailPage(
                                          key: widget.key,
                                        )));
                          },
                          message: 'Register',
                          color: const Color.fromARGB(255, 127, 99, 252))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CustomButtonWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => LoginPage(
                                        key: widget.key,
                                      )));
                        },
                        message: 'Login',
                        color: const Color.fromARGB(255, 123, 123, 123)),
                  ),
                  Container(
                    height: 50,
                  )
                ],
              ),
            ])));
  }
}
