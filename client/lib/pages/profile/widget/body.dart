import 'package:discord/model/user.model.dart';
import 'package:discord/pages/profile/data/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../edit.dart';

class BodyWidget extends StatefulWidget {
  final User userData;
  const BodyWidget({required this.userData, super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (settings[index]['button'] == 'Account') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) => EditProfile(userData: widget.userData)));
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: const Color.fromARGB(255, 50, 50, 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 10,
                        ),
                        Icon(
                          settings[index]['icon'],
                          color: settings[index]['button'] == 'Obtain Nitro'
                              ? const Color.fromARGB(255, 95, 140, 255)
                              : Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 195,
                            child: Text(
                              settings[index]['button'],
                              style: TextStyle(
                                  color: settings[index]['button'] ==
                                          'Obtain Nitro'
                                      ? const Color.fromARGB(255, 95, 140, 255)
                                      : Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          width: 110,
                        ),
                        const Icon(
                          CupertinoIcons.forward,
                          color: Colors.grey,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ])),
            );
          },
          itemCount: settings.length,
          separatorBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 1,
                  color: const Color.fromARGB(255, 50, 50, 50),
                  width: 20,
                ),
                Container(
                  height: 1,
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width - 20,
                )
              ],
            );
          },
        ));
  }
}
