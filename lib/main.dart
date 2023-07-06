import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sparrow/helpers/DarkMode/dark_provider.dart';
import 'package:sparrow/screens/BottomNav/BottomNav.dart';
import 'package:sparrow/screens/OtherUser.dart';
import 'package:sparrow/screens/change_password.dart';
import 'package:sparrow/screens/chat_screen/ChatScreen.dart';
import 'package:sparrow/screens/questions/editProperty.dart';
import 'package:sparrow/screens/registration/activateScreen.dart';
import 'package:sparrow/screens/questions/addProperty.dart';
import 'package:sparrow/screens/chat_screen/chatDetails.dart';
import 'package:sparrow/screens/home_screen/home_screen.dart';
import 'package:sparrow/screens/loginScreen.dart';
import 'package:sparrow/screens/registration/otp.dart';
import 'package:sparrow/screens/profile/profile_screen.dart';
import 'package:sparrow/screens/property_details.dart';
import 'package:sparrow/screens/registration/register.dart';
import 'package:sparrow/screens/sensor/Fingerprint.dart';
import 'package:sparrow/screens/sensor/Gyroscope.dart';
import 'package:sparrow/screens/sensor/LightSensor.dart';
import 'package:sparrow/screens/user_list.dart';
import 'package:sparrow/screens/profile/editProfile.dart';
import 'package:sparrow/screens/wearOS/Dashboard_wearOS.dart';
import 'package:sparrow/screens/wearOS/Login_wearOS.dart';
import 'package:sparrow/screens/searchScreen.dart';
import 'package:sparrow/screens/wearOS/ViewQsn_wearOS.dart';

void main() async {
  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
      channelGroupKey: "basic_channel_group",
      channelKey: 'basic_channel',
      channelName: "Basic Notification",
      channelDescription: "Notification with no sound",  
      defaultColor: const Color(0xFF00796B),
      importance: NotificationImportance.Max,
      ledColor: Colors.white,
      channelShowBadge: true,
    )
  ]);
  await Hive.initFlutter();
  await Hive.openBox('test');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            theme: MyThemes.lightTheme,
            initialRoute: '/',
            routes: {
              '/home': (context) => const HomeScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const Register(),
              '/otp': (context) => const otpVerificationScreen(),
              '/activate': (context) => const ActivateScreen(),
              '/question': (context) => const PropertyDetails(),
              '/profile': (context) => const ProfileScreen(),
              '/users': (context) => const UserLists(),
              '/add': (context) => const addProperty(),
              '/': (context) => const BottomNav(),
              '/search': (context) => const SearchScreen(),
              '/other': (context) => const OtherUser(),
              // '/stdreg': (context) => StudentReg(),
              '/change_password': (context) => const ChangePassword(),
              '/chat': (context) => const ChatPage(),
              '/chat_detail': (context) => const ChatDetails(),
              '/editQsn': (context) => const EditQuesion(),
              '/gyro': (context) => GyroscopeScreen(),
              // fingerprint sensor
              '/fingerprint': (context) => FingerprintPage(),
              '/edit_profile': (context) => EditProfilePage(),
              // For wear os
              '/wearos': (context) => const WOS_LoginScreen(),
              // wear os dashboard
              '/wearos_dashboard': (context) => const Dashboard_wearOS(),
              // view question
              '/wearos_view': (context) => const ViewQsn_WearOS(),
              // lightScreen
              '/light': (context) => LightScreen(),
            },
          );
        },
      );
}

  // nuts_activity_indicator: ^0.1.1
