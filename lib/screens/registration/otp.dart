import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/models/otp_response.dart';
// shared preferences
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Color colors = const Color(0xfffe9721);

class otpVerificationScreen extends StatefulWidget {
  const otpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<otpVerificationScreen> createState() => _otpVerificationScreenState();
}

class _otpVerificationScreenState extends State<otpVerificationScreen> {
  List<OtpHashData> hashedData = [];
  Logger logger = Logger();
  String? otp;
  String? hash;
  String? phone;

  addStringToSF(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    OtpHashData hashedData =
        ModalRoute.of(context)!.settings.arguments as OtpHashData;
    hash = hashedData.phone;
    phone = hashedData.hash;
    super.didChangeDependencies();
    // getx, riverpod, provider, bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/chat.png',
              width: 70,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "verify your phone number",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
                      // Text Field
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  onChanged: (value) => {otp = value},
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter OTP",
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: colors)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: colors)),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  APIService.VerifyOtp(phone!, otp!, hash!).then((value) {
                    addStringToSF(value['accessToken']);
                    logger.d(value['accessToken']);
                    // storage.write(key: "accessToken", value: value.accessToken);
                    Navigator.pushNamed(context, '/activate', arguments: value);
                    MotionToast.success(description: Text("Success"))
                        .show(context);
                  });
                },
                child: const Text(
                  'verify code',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "enter the code we just sent you",
              style: TextStyle(
                  color: Color.fromARGB(255, 195, 195, 195), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _textFieldOTP({bool? first, bool? last}) {
  return SizedBox(
    height: 65,
    child: AspectRatio(
      aspectRatio: 1.0,
      child: TextField(
        autofocus: true,
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(7)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 2, color: Color.fromARGB(255, 169, 64, 187)),
              borderRadius: BorderRadius.circular(7)),
        ),
      ),
    ),
  );
}
