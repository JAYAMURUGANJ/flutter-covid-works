import 'package:flutter/material.dart';
import 'package:ipab_ui/animation/fadeAnimation.dart';

class SwipPage extends StatefulWidget {
  @override
  _SwipPageState createState() => _SwipPageState();
}

class _SwipPageState extends State<SwipPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Image.asset(
                      'assets/images/indian_emblem.png',
                      width: 100,
                      height: 80,
                    ),
                  ),
                  FadeAnimation(
                    delay: 1.5,
                    child: Text(
                      'GOVERNMENT OF INDIA',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FadeAnimation(
                    delay: 2,
                    child: Text(
                      'MINISTRY OF COMMERCE & INDUSTRY',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    delay: 2.5,
                    child: ClipRRect(
                      //borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/images/ipab_banner1.jpg',
                          // width: 300,
                          height: 150,
                          fit: BoxFit.fill),
                    ),
                  ),
                  FadeAnimation(
                    delay: 3,
                    child: Image.asset(
                      'assets/images/ipab_logo.jpg',
                      width: 120,
                      height: 80,
                    ),
                  ),
                  FadeAnimation(
                    delay: 3.5,
                    child: Text(
                      'INTELLECTUAL PROPERTY',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FadeAnimation(
                    delay: 4,
                    child: Text(
                      'APPELLATE BOARD',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SwipButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //color: const Color(0xff7c94b6),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Contact Us:',
                          style: TextStyle(color: Colors.black54),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Deputy Registrar, IPAB',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Email:',
                          style: TextStyle(color: Colors.black54),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'ipab.tn@nic.in   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Phone:'),
                            TextSpan(
                                text: '044-24328902/03',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}

class SwipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.orangeAccent,
          shape: CircleBorder(),
        ),
        child: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
    );
  }
}
