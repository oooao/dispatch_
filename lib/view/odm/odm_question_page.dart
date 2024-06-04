// import 'package:dispatch/view/odm/odm_request_form_page.dart';
// import 'package:flutter/material.dart';
// import 'package:kartal/kartal.dart';

// class ODMQuestionPage extends StatefulWidget {
//   const ODMQuestionPage({super.key});

//   @override
//   _ODMQuestionPageState createState() => _ODMQuestionPageState();
// }

// class _ODMQuestionPageState extends State<ODMQuestionPage> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset('assets/images/TextLogo.png'),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 20, right: 20),
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
//   int index = 0;
//   int num_of_questions = 4;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               context.emptySizedHeightBoxLow3x,
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: buildQuestion(),
//               ),
//               context.emptySizedHeightBoxLow3x,
//               SizedBox(
//                 width: 180,
//                 height: 50,
//                 child: ElevatedButton(
//                     onPressed: () async {
//                       if (index < num_of_questions - 1) {
//                         setState(() {
//                           index++;
//                         });
//                       } else {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const ODMRequestFormPage()),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                     ),
//                     child: const Text('下一步', style: TextStyle(fontSize: 20))),
//               ),
//               context.emptySizedHeightBoxLow3x,
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildQuestion() {
//     if (index == 0) {
//       return buildQuestion1();
//     } else if (index == 1) {
//       return buildQuestion2();
//     } else if (index == 2) {
//       return buildQuestion3();
//     }
//     if (index == 3) {
//       return buildQuestion4();
//     }
//     return Container();
//   }

//   bool _option1 = false;
//   bool _option2 = false;
//   bool _option3 = false;
//   Widget buildQuestion1() {
//     return Container(
//       child: Column(
//         children: [
//           const Text(
//             "裝修目的",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           CheckboxListTile(
//             value: _option1,
//             title: const Text("全室裝修"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option1 = value!;
//                 if (_option1 == true) {
//                   _option2 = false;
//                   _option3 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option2,
//             title: const Text("局部改造"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option2 = value!;
//                 if (_option2 == true) {
//                   _option1 = false;
//                   _option3 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option3,
//             title: const Text("舊屋翻新"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option3 = value!;
//                 if (_option3 == true) {
//                   _option1 = false;
//                   _option2 = false;
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   bool _option21 = false;
//   bool _option22 = false;
//   bool _option23 = false;
//   bool _option24 = false;
//   Widget buildQuestion2() {
//     return Container(
//       child: Column(
//         children: [
//           const Text(
//             "價格預算",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           CheckboxListTile(
//             value: _option21,
//             title: const Text("5000-35000"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option21 = value!;
//                 if (_option21 == true) {
//                   _option22 = false;
//                   _option23 = false;
//                   _option24 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option22,
//             title: const Text("35000-70000"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option22 = value!;
//                 if (_option22 == true) {
//                   _option21 = false;
//                   _option23 = false;
//                   _option24 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option23,
//             title: const Text("70000-120000"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option23 = value!;
//                 if (_option23 == true) {
//                   _option21 = false;
//                   _option22 = false;
//                   _option24 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option24,
//             title: const Text("120000以上"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option24 = value!;
//                 if (_option24 == true) {
//                   _option21 = false;
//                   _option22 = false;
//                   _option23 = false;
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   bool _option31 = false;
//   bool _option32 = false;
//   bool _option33 = false;
//   bool _option34 = false;
//   Widget buildQuestion3() {
//     return Container(
//       child: Column(
//         children: [
//           const Text(
//             "單選問題",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           CheckboxListTile(
//             value: _option31,
//             title: const Text("選項1"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option31 = value!;
//                 if (_option31 == true) {
//                   _option32 = false;
//                   _option33 = false;
//                   _option34 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option32,
//             title: const Text("選項2"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option32 = value!;
//                 if (_option32 == true) {
//                   _option31 = false;
//                   _option33 = false;
//                   _option34 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option33,
//             title: const Text("選項3"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option33 = value!;
//                 if (_option33 == true) {
//                   _option31 = false;
//                   _option32 = false;
//                   _option34 = false;
//                 }
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option34,
//             title: const Text("選項4"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option34 = value!;
//                 if (_option34 == true) {
//                   _option31 = false;
//                   _option32 = false;
//                   _option33 = false;
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   bool _option41 = false;
//   bool _option42 = false;
//   bool _option43 = false;
//   bool _option44 = false;
//   Widget buildQuestion4() {
//     return Container(
//       child: Column(
//         children: [
//           const Text(
//             "多選問題",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           CheckboxListTile(
//             value: _option41,
//             title: const Text("選項1"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option41 = value!;
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option42,
//             title: const Text("選項2"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option42 = value!;
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option43,
//             title: const Text("選項3"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option43 = value!;
//               });
//             },
//           ),
//           CheckboxListTile(
//             value: _option44,
//             title: const Text("選項4"),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (value) {
//               setState(() {
//                 _option44 = value!;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
