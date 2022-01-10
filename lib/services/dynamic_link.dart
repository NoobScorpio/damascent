// import 'dart:convert';

// import 'package:damascent/constants/common_functions.dart';
// import 'package:damascent/constants/constants.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DynamicLinkClass {
//   static void initDynamicLinks(context, loggedIn) async {
//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();

//     if (data != null) {
//       final Uri deepLink = data.link;
//       handleDynamicLink(deepLink, context, loggedIn);
//     }
//     FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) async {
//       final Uri uri = dynamicLink.link;
//       final params = uri.queryParameters;
//       if (params.isNotEmpty) {}
//     });
//   }

//   static Future<String> buildDynamicLink({uid, desc, image, name}) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: uriPrefix,
//       link: Uri.parse("$uriPrefix/profile/$uid"),
//       androidParameters: const AndroidParameters(
//         packageName: "com.damascent.damascent",
//         minimumVersion: 21,
//       ),
//       iosParameters: const IOSParameters(
//           bundleId: "com.damascent.damascent", minimumVersion: '0'),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         description: desc,
//         imageUrl: Uri.parse(image),
//         title: name,
//       ),
//     );
//     final dynamicLink =
//         await FirebaseDynamicLinks.instance.buildLink(parameters);
//     return dynamicLink.toString();
//   }

//   static void handleDynamicLink(Uri url, context, loggedIn) async {
//     List<String> separated = [];
//     separated.addAll(url.path.split("/"));
//     if (url.path.contains("agent")) {
//       SharedPreferences preferences = await SharedPreferences.getInstance();

//       String discount;

//       discount = json.encode({"agent": "age", "discount": 5, "applied": false});
//       await preferences.setString(prefAgent, discount);
//       showToast("Your discount is applied", Constants.primaryColor);
//     }
//   }
// }
