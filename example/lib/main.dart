import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mynewpackage/model/super_gryd_story.dart';
import 'package:mynewpackage/mynewpackage.dart';
import 'package:mynewpackage/widgets/story_widget.dart';
import 'package:mynewpackage/widgets/super_gryd_app.dart';

void main() {
  SuperGrydApp.initialize(
    clientId: 'SGD_test_55be429e-485b-45c2-b281-3f818d32769a',
    clientSecret: 'SGD_test_8a680b2b-f8d0-491a-8346-63f3a2cace04',
  );
  SuperGrydApp.instance.onError.listen((e) {
    log("Exception captured in host ${e.exception},stack ${e.stackTrace}");
  });
  SuperGrydApp.createUser(mobile: "9537212345", username: "Michael");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates:  const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', ''),
      // ],
      // fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Mullish",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StoryWidget(
            storyData: [
              // SuperGrydStory(
              //     storyData: [
              //       SuperGrydStoryData(
              //           imageUrl:
              //               "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?cs=srgb&dl=pexels-chloekalaartist-1043471.jpg&fm=jpg&w=640&h=960",
              //           title: "Story 1")
              //     ],
              //     thumbUrl:
              //         "https://images.pexels.com/photos/16715674/pexels-photo-16715674.jpeg?cs=srgb&dl=pexels-stephen-noulton-421904730-16715674.jpg&fm=jpg&w=640&h=640"),
              // SuperGrydStory(
              //     storyData: [
              //       SuperGrydStoryData(
              //           imageUrl:
              //               "https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?cs=srgb&dl=pexels-jack-winbow-460463-1559486.jpg&fm=jpg&w=640&h=960",
              //           title: "Story 2")
              //     ],
              //     thumbUrl:
              //         "https://images.pexels.com/photos/10311994/pexels-photo-10311994.jpeg?cs=srgb&dl=pexels-nurlantortbayev-10311994.jpg&fm=jpg&w=640&h=640"),
              SuperGrydStory(
                  storyData: [
                    SuperGrydStoryData(
                        url: "https://amzn.in/d/01lpvNt7",
                        imageUrl:
                            "https://images.pexels.com/photos/16715674/pexels-photo-16715674.jpeg?cs=srgb&dl=pexels-stephen-noulton-421904730-16715674.jpg&fm=jpg&w=640&h=640",
                        title: "Click to see new offers")
                  ],
                  thumbUrl:
                      "https://images.pexels.com/photos/16715674/pexels-photo-16715674.jpeg?cs=srgb&dl=pexels-stephen-noulton-421904730-16715674.jpg&fm=jpg&w=640&h=640"),
              SuperGrydStory(
                  storyData: [
                    SuperGrydStoryData(
                        imageUrl:
                            "https://images.pexels.com/photos/10311994/pexels-photo-10311994.jpeg?cs=srgb&dl=pexels-nurlantortbayev-10311994.jpg&fm=jpg&w=640&h=640",
                        title: "Story 2")
                  ],
                  thumbUrl:
                      "https://images.pexels.com/photos/10311994/pexels-photo-10311994.jpeg?cs=srgb&dl=pexels-nurlantortbayev-10311994.jpg&fm=jpg&w=640&h=640"),
              SuperGrydStory(
                  storyData: [
                    SuperGrydStoryData(
                        title: ""
                            "Buy 2 Get 1 for purchases worth 1999\n"
                            "Buy 1 get 1 for purchases worth 3999\n"
                            "#Offers")
                  ],
                  thumbUrl:
                      "https://img.freepik.com/premium-psd/editable-text-promo-offer-with-3d-style-effect_16148-2865.jpg?w=1380"),
            ],
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyPackage(

                          // clientId: 'SGD_test_55be429e-485b-45c2-b281-3f818d32769a',
                          // clientSecrete: 'SGD_test_8a680b2b-f8d0-491a-8346-63f3a2cace04',
                          // name: '',
                          // mobile: '',
                          )));
                },
                child: const Text("Go to myPackage")),
          ),
        ],
      ),
    );
  }
}
