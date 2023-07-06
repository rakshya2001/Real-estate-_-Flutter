import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuthAPI {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {

    // check if fingerprint auth is available
    final isAvailable = await _auth.isDeviceSupported();
    if(!isAvailable) {
      return false;
    }

    // then authenticate with fingerprint
    try {
      return await _auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(useErrorDialogs: true)
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }
}
