import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/providers/seeker_profile_provider.dart'; // The provider
// SeekerProfileModel will be used inside the provider, so no need to import directly here

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeekerProfileProvider>(
      create: (_) => SeekerProfileProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          fontFamily: 'Somar Sans',
        ),
        home: const WelcomePage(),
      ),
    );
  }
}


// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(),
//   ),
// );
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//         scaffoldBackgroundColor: scaffoldColor,
//         fontFamily: 'Somar Sans',
//
//       ),
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       debugShowCheckedModeBanner: false,
//       home: NavBar(),
//     );
//   }
// }