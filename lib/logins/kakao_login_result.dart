// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk/user.dart';

// class KakaoLoginResult extends StatefulWidget {
//   @override
//   _KakaoLoginResultState createState() => _KakaoLoginResultState();
// }

// class _KakaoLoginResultState extends State<KakaoLoginResult> {
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initTexts();
//   }

//   _initTexts() async {
//     final User user = await UserApi.instance.me();

//     print(
//         "=========================[kakao account]=================================");
//     print(user.kakaoAccount.toString());
//     print(
//         "=========================[kakao account]=================================");

//     setState(() {
//       _accountEmail = user.kakaoAccount.email;
//       _ageRange = user.kakaoAccount.ageRange.toString();
//       _gender = user.kakaoAccount.gender.toString();
//     });
//   }

//   String _accountEmail = 'None';
//   String _ageRange = 'None';
//   String _gender = 'None';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               Text(
//                 _accountEmail,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 _ageRange,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 _gender,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
