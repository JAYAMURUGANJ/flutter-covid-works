import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_logout/states/app_state.dart';
import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: AppState(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'uber clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Uber clone'),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_map_polyline/google_map_polyline.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission/permission.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final Set<Polyline> polyline = {};

//   // ignore: unused_field
//   GoogleMapController _controller;
//   List<LatLng> routeCoords;
//   GoogleMapPolyline googleMapPolyline =
//       new GoogleMapPolyline(apiKey: "AIzaSyBW17wIOnVlKmBb2XGmzvuWjtH7KttfdPQ");

//   getsomePoints() async {
//     var permissions =
//         await Permission.getPermissionsStatus([PermissionName.Location]);
//     if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
//       // ignore: unused_local_variable
//       var askpermissions =
//           await Permission.requestPermissions([PermissionName.Location]);
//     } else {
//       routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
//           origin: LatLng(40.6782, -73.9442),
//           destination: LatLng(40.6944, -73.9212),
//           mode: RouteMode.driving);
//     }
//   }

//   getaddressPoints() async {
//     routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
//         origin: '55 Kingston Ave, Brooklyn, NY 11213, USA',
//         destination: '178 Broadway, Brooklyn, NY 11211, USA',
//         mode: RouteMode.driving);
//   }

//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     getaddressPoints();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//       onMapCreated: onMapCreated,
//       polylines: polyline,
//       initialCameraPosition:
//           CameraPosition(target: LatLng(40.6782, -73.9442), zoom: 14.0),
//       mapType: MapType.normal,
//     ));
//   }

//   void onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _controller = controller;

//       polyline.add(Polyline(
//           polylineId: PolylineId('route1'),
//           visible: true,
//           points: routeCoords,
//           width: 4,
//           color: Colors.blue,
//           startCap: Cap.roundCap,
//           endCap: Cap.buttCap));
//     });
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_login_logout/map.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Glogin & Gmap',
//       home: new Glogin(),
//       // routes: <String, WidgetBuilder>{
//       //   '/settings': (BuildContext context) => new SettingsPage(),
//       // },
//     );
//   }
// }

// class Glogin extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _GloginState();
//   }
// }

// class _GloginState extends State<Glogin> {
//   bool _isLoggedIn = false;

//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   _login() async {
//     try {
//       await _googleSignIn.signIn();
//       setState(() {
//         _isLoggedIn = true;
//       });
//     } catch (err) {
//       print(err);
//     }
//   }

//   _logout() {
//     _googleSignIn.signOut();
//     setState(() {
//       _isLoggedIn = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Glogin'),
//         backgroundColor: Colors.blue[900],
//       ),
//       body: Center(
//           child: _isLoggedIn
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     OutlineButton(
//                       child: Text("Map View"),
//                       onPressed: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) => MapView()));
//                       },
//                     ),
//                     Image.network(
//                       _googleSignIn.currentUser.photoUrl,
//                       height: 50.0,
//                       width: 50.0,
//                     ),
//                     Text(_googleSignIn.currentUser.displayName),
//                     OutlineButton(
//                       child: Text("Logout"),
//                       onPressed: () {
//                         _logout();
//                       },
//                     )
//                   ],
//                 )
//               : Center(
//                   child: OutlineButton(
//                     child: Text("Login with Google"),
//                     onPressed: () {
//                       _login();
//                     },
//                   ),
//                 )),
//     );
//   }
// }
