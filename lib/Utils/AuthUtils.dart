import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

const iosStrings = const IOSAuthMessages(
  cancelButton: 'انصراف',
  goToSettingsButton: 'تنظیمات',
  goToSettingsDescription: 'لطفا اثرانگشت خود را تنظیم کنید.',
  lockOut: 'لطفا دوباره اثر انگشت را فعال کنید',
);

const androidStrings = const AndroidAuthMessages(
  cancelButton: 'انصراف',
  goToSettingsButton: 'تنظیمات',
  biometricHint: "",
  biometricRequiredTitle: "ورود با اثر انگشت",
  deviceCredentialsRequiredTitle: "",
  signInTitle: "ورود با اثر انگشت",
  goToSettingsDescription: 'لطفا اثرانگشت خود را تنظیم کنید.',
);

Future<bool> authenticate(String desc) async {
  LocalAuthentication localAuth = LocalAuthentication();
  return await localAuth.authenticate(
    localizedReason: desc,
    androidAuthStrings: androidStrings,
    iOSAuthStrings: iosStrings,
    biometricOnly: true,
  );
}
