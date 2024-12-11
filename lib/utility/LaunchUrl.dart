/// This file defines a class for launching URLs in a Flutter application.
/// The class uses the [url_launcher] package to open URLs in the default browser or app.

import 'package:url_launcher/url_launcher.dart';


  /// A method to redirect to the provided URL using the default browser or app.
  ///
  /// The function checks if the URL can be launched, and if successful, it will open the URL.
  /// If the URL cannot be launched, it throws an exception with the URL as the message.
  ///
  /// Args:
  ///   [url] (String): The URL to be opened in the browser or corresponding app.
  ///
  /// Throws:
  ///   [Exception]: If the URL cannot be launched, an exception with the URL is thrown.
  void LaunchURL(String url) async {
    final Uri urlRedirect = Uri.parse(url);
    await launchUrl(urlRedirect);
  }

