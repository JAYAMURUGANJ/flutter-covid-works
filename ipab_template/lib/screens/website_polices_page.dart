import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebsitePolices extends StatefulWidget {
  @override
  _WebsitePolicesState createState() => _WebsitePolicesState();
}

class _WebsitePolicesState extends State<WebsitePolices> {
  @override
  Widget build(BuildContext context) {
    TextStyle menuFontStyle = GoogleFonts.aBeeZee(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor);
    TextStyle submenuFontStyle = GoogleFonts.aBeeZee(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor);
    Color menuIconStyle = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Website Polices'),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                border: new Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 10.0,
                ),
              ),
              child: Image.asset(
                'assets/images/websitepolicies.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpandableCardDetails(
              menuIconStyle: menuIconStyle,
              menuFontStyle: menuFontStyle,
              isExpand: false,
              title: 'Terms of Use',
              details:
                  'Intellectual Property Appellate Board (IPAB) is managing the content of the portal. Though all efforts have been made to ensure the accuracy and currency of the content on this Portal, the same should not be construed as a statement of law or used for any legal purposes. In no event will the IPAB be liable for any expense, loss or damage including, without limitation, indirect or consequential loss or damage, or any expense, loss or damage whatsoever arising from use, or loss of use, of data, arising out of or in connection with the use of this Portal. Links to other websites that have been included on this Portal are provided for public convenience only. IPAB is not responsible for the contents or reliability of linked websites. We cannot guarantee the availability of such linked pages at all times. These terms and conditions shall be governed by and construed in accordance with the Indian Laws. Any dispute arising under these terms and conditions shall be subject to the exclusive jurisdiction of the courts of India.',
            ),
            ExpandableCardDetails(
              menuIconStyle: menuIconStyle,
              menuFontStyle: menuFontStyle,
              isExpand: false,
              title: 'Privacy Policy',
              details:
                  'This website does not automatically capture any specific personal information from you, (like name, phone number or e-mail address), that allows us to identify you individually. If the website requests you to provide personal information, you will be informed for the particular purposes for which the information is gathered e.g. feedback form and adequate security measures will be taken to protect your personal information. We do not sell or share any personally identifiable information volunteered on the website site to any third party (public/private). Any information provided to this website will be protected from loss, misuse, unauthorized access or disclosure, alteration, or destruction. We gather certain information about the User, such as Internet protocol (IP) addresses, domain name, browser type, operating system, the date and time of the visit and the pages visited. We make no attempt to link these addresses with the identity of individuals visiting our site unless an attempt to damage the site has been detected.',
            ),
            ExpandableCardDetails2(
              menuIconStyle: menuIconStyle,
              menuFontStyle: menuFontStyle,
              submenuFontStyle: submenuFontStyle,
              isExpand: false,
              title: 'Hyper Linking Policy',
              subtitle1: 'Links to external websites/portals:',
              details1:
                  'This website does not automatically capture any specific personal information from you, (like name, phone number or e-mail address), that allows us to identify you individually. If the website requests you to provide personal information, you will be informed for the particular purposes for which the information is gathered e.g. feedback form and adequate security measures will be taken to protect your personal information. We do not sell or share any personally identifiable information volunteered on the website site to any third party (public/private). Any information provided to this website will be protected from loss, misuse, unauthorized access or disclosure, alteration, or destruction. We gather certain information about the User, such as Internet protocol (IP) addresses, domain name, browser type, operating system, the date and time of the visit and the pages visited. We make no attempt to link these addresses with the identity of individuals visiting our site unless an attempt to damage the site has been detected.',
              subtitle2: 'Links to this Portal by other websites:',
              details2:
                  'We do not object to you linking directly to the information that is hosted on this Portal and no prior permission is required for the same. However, we would like you to inform us about any links provided to this Portal so that you can be informed of any changes or updation that are carried on therein. Also, we do not permit our pages to be loaded into frames on any third party sites. The pages belonging to this Portal must load into a newly opened browser window of the User.',
            ),
            ExpandableCardDetails(
              menuIconStyle: menuIconStyle,
              menuFontStyle: menuFontStyle,
              isExpand: false,
              title: 'Disclaimer:',
              details:
                  'Welcome to the Portal of Intellectual Property Appellate Board (IPAB). On this portal, you shall find information about information published by various sections under the Intellectual Property Appellate Board (IPAB). This Service is being provided by the Intellectual Property Appellate Board (IPAB) in association with National Informatics Centre (NIC) to facilitate faster dissemination and easy access to information published in this portal. However, the Information contents are owned, published and maintained by the concerned User Organisations / Sections and they are responsible for their accuracy, authenticity and validity. In case of doubt or query, users are requested to refer to the original publisher of Information and / or contact the respective Section / Department / Organisation.',
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableCardDetails extends StatelessWidget {
  const ExpandableCardDetails({
    Key key,
    @required this.menuIconStyle,
    @required this.menuFontStyle,
    @required this.title,
    @required this.details,
    @required this.isExpand,
  }) : super(key: key);

  final Color menuIconStyle;
  final TextStyle menuFontStyle;
  final String title;
  final String details;
  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(5, 5),
                blurRadius: 2,
              ),
            ]),
        child: ExpansionTile(
          initiallyExpanded: isExpand,
          leading: Icon(
            Icons.assignment,
            color: menuIconStyle,
          ),
          title: Text(
            title,
            style: menuFontStyle,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        details,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExpandableCardDetails2 extends StatelessWidget {
  const ExpandableCardDetails2(
      {Key key,
      @required this.menuIconStyle,
      @required this.menuFontStyle,
      @required this.title,
      @required this.isExpand,
      this.submenuFontStyle,
      this.details1,
      this.details2,
      this.subtitle1,
      this.subtitle2})
      : super(key: key);

  final Color menuIconStyle;
  final TextStyle menuFontStyle;
  final String title;
  final bool isExpand;
  final TextStyle submenuFontStyle;
  final String details1;
  final String details2;
  final String subtitle1;
  final String subtitle2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(5, 5),
                blurRadius: 2,
              ),
            ]),
        child: ExpansionTile(
          initiallyExpanded: isExpand,
          leading: Icon(
            Icons.assignment,
            color: menuIconStyle,
          ),
          title: Text(
            title,
            style: menuFontStyle,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          subtitle1,
                          style: submenuFontStyle,
                        ),
                      ),
                      Divider(),
                      Text(
                        details1,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          subtitle2,
                          style: submenuFontStyle,
                        ),
                      ),
                      Divider(),
                      Text(
                        details2,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
