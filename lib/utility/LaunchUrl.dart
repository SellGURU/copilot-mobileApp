import 'package:url_launcher/url_launcher.dart';
class LaunchURL{
  void rediractUrl(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw '$url';
    }
  }
}
