// import 'dart:async';

// import 'package:dispatch/view/widgets/custom_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:kartal/kartal.dart';

// class RequestPage extends StatefulWidget {
//   const RequestPage({super.key});

//   @override
//   _RequestPageState createState() => _RequestPageState();
// }

// class _RequestPageState extends State<RequestPage> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset('assets/images/TextLogo.png'),
//         centerTitle: true,
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         padding:  EdgeInsets.only(left: 20.w, right: 20.w),
//         child: _Form(),
//       ),
//     );
//   }
// }

// class _Form extends StatefulWidget {
//   @override
//   __FormState createState() => __FormState();
// }

// class __FormState extends State<_Form> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final bool _obscurePassword = true;
//   final emailCtrl = TextEditingController();
//   final passwordCtrl = TextEditingController();
//   final passwordConfirmCtrl = TextEditingController();
//   final userNameCtrl = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   bool isShowMap = false;
//   final String BROWSER_KEY = "AIzaSyAEGxQ_VPJIS85WLFDVfusc1P_1_-dNH8k";

//   final Completer<GoogleMapController> _controller = Completer();

//   final double _default_zoom = 18;
//   final LatLng _default_lat_lng = const LatLng(25.042140699999994, 121.51987160000002);

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition().then((value) async {
//       final GoogleMapController controller = await _controller.future;
//       CameraPosition current = CameraPosition(
//         target: LatLng(value.latitude, value.longitude),
//         zoom: 17,
//       );
//       controller.animateCamera(CameraUpdate.newCameraPosition(current));
//       GeoData geoData = await Geocoder2.getDataFromCoordinates(
//           latitude: value.latitude,
//           longitude: value.longitude,
//           googleMapApiKey: BROWSER_KEY,
//           language: "zh-TW");
//       setState(() {
//         addressController.text = geoData.address;
//       });
//     });
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             context.emptySizedHeightBoxLow3x,
//              Padding(
//               padding: EdgeInsets.only(left: 40.w, right: 40.w),
//               child: CustomTextField(
//                 labelText: "需求日期",
//                 suffixIcon: Icon(Icons.date_range),
//               ),
//             ),
//             context.emptySizedHeightBoxLow,
//             Padding(
//               padding:  EdgeInsets.only(left: 40.w, right: 40.w),
//               child: CustomTextField(
//                 labelText: "派工地點",
//                 controller: addressController,
//                 suffixIcon: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isShowMap = !isShowMap;
//                       });
//                     },
//                     child: const Icon(Icons.map)),
//               ),
//             ),
//             context.emptySizedHeightBoxLow,
//             Visibility(
//               visible: isShowMap,
//               child: Container(
//                 height: 300,
//                 padding:  EdgeInsets.only(left: 40.w, right: 40.w),
//                 child: GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: CameraPosition(
//                     target: _default_lat_lng,
//                     zoom: _default_zoom,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                 ),
//               ),
//             ),
//              Padding(
//               padding: EdgeInsets.only(left: 40.w, right: 40.w),
//               child: CustomTextField(
//                 labelText: "案場照片",
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//             SizedBox(
//               width: 180,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   /*Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                 );*/
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: const Text('送出需求'),
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//           ],
//         ),
//       ),
//     );
//   }
// }
