// import 'package:flutter/material.dart';
// import 'package:remind_me/services/auth/auth_services.dart';
// import 'package:remind_me/views/widgets/buttons/flexible_button.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isLoading = false;

//   void signOut() async {
//     await AuthServices().signOut(context);
//     isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Center(
//         child: FlexibleButton(
//           isLoading: isLoading,
//           text: "Sign Out",
//           onPressed: () {
//             setState(() {
//               isLoading = true;
//             });
//             signOut();
//           },
//           margin: EdgeInsets.only(left: 50, right: 50),
//           width: size.width / 2,
//         ),
//       ),
//     );
//   }
// }
