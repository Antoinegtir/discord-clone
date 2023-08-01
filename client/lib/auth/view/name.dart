import 'package:discord/auth/view/signup.dart';
import 'package:discord/widget/custombutton.widget.dart';
import 'package:discord/widget/textfield.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> children = <int, Widget>{
      0: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Phone',
            style: TextStyle(
                color: currentIndex == 0 ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w800),
          )),
      1: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Email',
            style: TextStyle(
                color: currentIndex == 1 ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w800),
          )),
    };
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
              ),
              const Text(
                'Enter phone or email',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                  width: 400,
                  height: 80,
                  child: CupertinoSlidingSegmentedControl<int>(
                    backgroundColor: const Color.fromARGB(255, 36, 36, 36),
                    thumbColor: const Color.fromARGB(255, 126, 126, 126),
                    children: children,
                    groupValue: currentIndex,
                    onValueChanged: (int? newValue) {
                      HapticFeedback.mediumImpact();
                      setState(() {
                        currentIndex = newValue!;
                        _tabController.animateTo(currentIndex);
                      });
                    },
                  )),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child:
                      TabBarView(controller: _tabController, children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                      color:
                                          const Color.fromARGB(255, 24, 24, 24),
                                      height: 70,
                                      width: 120,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Country Code',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 94, 94, 94)),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              '+33',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ))),
                              const SizedBox(
                                width: 10,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                      color:
                                          const Color.fromARGB(255, 24, 24, 24),
                                      height: 70,
                                      width: 203,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Phone number',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 94, 94, 94)),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              '+33',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ))),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'View our Privacy Policy',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 33, 184, 243)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  color:
                                      const Color.fromARGB(255, 127, 99, 252),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFieldWidget(
                            textEditingController: emailController,
                            hint: 'email',
                            color: const Color.fromARGB(255, 24, 24, 24)),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'View our Privacy Policy',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 33, 184, 243)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            child: CustomButtonWidget(
                              onPressed: () {
                                if (emailController.text.isNotEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              SignUpPage(
                                                email: emailController.text,
                                                key: widget.key,
                                              )));
                                }
                              },
                              message: 'Next',
                              color: const Color.fromARGB(255, 127, 99, 252),
                            )),
                      ],
                    )
                  ]))
            ],
          ),
        ));
  }
}
