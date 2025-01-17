import 'package:installed_apps/installed_apps.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCamera() async {
  var cameraUri = Uri.parse("content://media/external/images/media/");

  if (await canLaunchUrl(cameraUri)) {
    await launchUrl(cameraUri);
  } else {
    throw 'Не удалось открыть приложение камеры';
  }
}

Future<void> launchApp(String packageName) async {
  InstalledApps.startApp(packageName);
}

Future<void> launchGoogle() async {
  // var google = Uri.parse("google.search://search");
  var google = Uri.parse("https://www.google.com");

  if (await canLaunchUrl(google)) {
    await launchUrl(google);
  } else {
    throw 'Не удалось открыть приложение телефона';
  }
}

Future<void> launchGoogleWithUrl(String url) async {
  // var google = Uri.parse("google.search://search");
  var google = Uri.parse("https://$url");

  if (await canLaunchUrl(google)) {
    await launchUrl(google);
  } else {
    throw 'Не удалось открыть приложение телефона';
  }
}



Future<void> launchPhone() async {
  var telUri = Uri(scheme: "tel");

  if (await canLaunchUrl(telUri)) {
    await launchUrl(telUri);
  } else {
    throw 'Не удалось открыть приложение телефона';
  }
}

