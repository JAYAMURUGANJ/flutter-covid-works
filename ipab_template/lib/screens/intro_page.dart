import 'package:flutter/material.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:ipab_template/screens/home_page.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                verticalDirection: VerticalDirection.down,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/indian_emblem.png',
                    width: 100,
                    height: 80,
                  ),
                  Text(
                    getTranslated(context, 'goverment_of_india'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getTranslated(context, 'ministry'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.asset('assets/images/ipab_banner1.jpg',
                              // width: 300,
                              height: 150,
                              fit: BoxFit.fill),
                        ),
                        Image.asset(
                          'assets/images/ipab_logo.jpg',
                          width: 120,
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    getTranslated(context, 'ip'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getTranslated(context, 'ab'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
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
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: FlatButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Go',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )),
    );
  }
}
