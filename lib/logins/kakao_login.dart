// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kakao_flutter_sdk/all.dart';

// import 'kakao_login_result.dart';

// class KakaoLogin extends StatefulWidget {
//   final bool isInstalled = false;

//   @override
//   _KakaoLoginState createState() => _KakaoLoginState();
// }

// class _KakaoLoginState extends State<KakaoLogin> {
//   bool _isKakaoTalkInstalled = false;

//   @override
//   void initState() {
//     _initKakaoTalkInstalled();
//     super.initState();
//   }

//   _initKakaoTalkInstalled() async {
//     final installed = await isKakaoTalkInstalled();
//     print('kakao install: ' + installed.toString());
//     setState(() {
//       _isKakaoTalkInstalled = installed;
//     });
//   }

//   _issueAccessToken(String authCode) async {
//     try {
//       var token = await AuthApi.instance.issueAccessToken(authCode);
//       AccessTokenStore.instance.toStore(token);
//       print(token.accessToken);
//       Get.to(() => KakaoLoginResult());
//     } catch (e) {
//       print('에러: ' + e.toString());
//     }
//   }

//   _loginWithKakao() async {
//     try {
//       var code = await AuthCodeClient.instance.request();
//       await _issueAccessToken(code);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   _loginWithTalk() async {
//     try {
//       var code = await AuthCodeClient.instance.request();
//       await _issueAccessToken(code);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao(),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.6,
//         height: MediaQuery.of(context).size.height * 0.07,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.yellow,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.chat_bubble,
//               color: Colors.black54,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               '카카오 계정 로그인',
//               style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w900,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
