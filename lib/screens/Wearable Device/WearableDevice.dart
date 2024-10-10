import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/screens/Wearable%20Device/authorizersRook/cubit.dart';
import 'package:copilet/screens/Wearable%20Device/authorizersRook/cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/endPoints.dart';
import 'authorizersRook/state.dart';

class WearableDevice extends StatefulWidget {
  const WearableDevice({super.key});

  @override
  State<WearableDevice> createState() => _WearableDeviceState();
}

class _WearableDeviceState extends State<WearableDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Wearable Device"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Navigate back when pressed
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Sync your health data effortlessly by connecting with Health Applications. By integrating, track your progress across all your devices, and make the most of your health journey.",
                style: AppTextStyles.titleMediumHeight,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<AuthorizersRookCubit, AuthorizersRookState>(
                builder: (context, state) {
                  if (state is SuccessAuthorizersRookState) {
                    // Make sure that state.data is a List
                    return Column(
                      children: state.data.map<Widget>((item) {
                        // Assuming 'item' is a map containing data like image, link, and title
                        return ConnectCard(
                          image: item['image'] ??
                              '', // Assuming 'image' is a key in the state.data[0 map
                          link: item['authorization_url'] ??
                              '', // Assuming 'link' is a key in the state.data[0 map
                          title: item['name'] ?? '',
                          connected: item[
                              'connected'], // Assuming 'title' is a key in the item map
                        );
                      }).toList(),
                    );
                  } else {
                    // Show a loading spinner while loading data
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectCard extends StatelessWidget {
  String link;
  String image;
  String title;
  bool connected;

  ConnectCard(
      {super.key,
      required this.image,
      required this.connected,
      required this.link,
      required this.title});
  void _launchURL(String url) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  image,
                  width: 40,
                  height: 40,
                )),
            // child: SvgPicture.asset("assets/fitbit.svg")),
            const SizedBox(width: 16),
            // Text information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Apple Health', style: AppTextStyles.hintMedium),
                  const SizedBox(height: 4),
                  Text('Version: 1,2,3', style: AppTextStyles.hint),
                ],
              ),
            ),
            // Connect button
            ElevatedButton(
              onPressed: () async {
                Dio _dio = Dio();
                await _dio.post(Endpoints.add_event, data: {
                  "event_type": "connected",
                  "event_name": title
                });
                _launchURL(link);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: connected
                    ? Colors.greenAccent.withOpacity(.3)
                    : Colors.white,
                // primary: Colors.transparent,
                // onPrimary: Colors.purple,
                side:
                    const BorderSide(color: AppColors.iconPurpleDark, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(connected  ? "Connected" : 'Connect',
                  style: AppTextStyles.hintPurple),
            ),
          ],
        ),
      ),
    );
  }
}
