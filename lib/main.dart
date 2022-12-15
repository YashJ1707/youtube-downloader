import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int itag = 18;
  String error = "";
  String link = "";
  // bool isSelected1 = true;
  // bool isSelected2 = false;
  // bool isSelected3 = false;

  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/bg.jpeg"), fit: BoxFit.fitHeight),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/yt_logo.png",
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitHeight,
                ),
                const Text(
                  "Downloader",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: urlController,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: "Url",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                qualityButton(quality: "360p"),
                const SizedBox(
                  height: 10,
                ),
                qualityButton(quality: "720p"),
                const SizedBox(
                  height: 10,
                ),
                qualityButton(quality: "1080p"),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: const Text(
                    "Download",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    // MaterialStateProperty.all(Colors.red),
                    elevation: MaterialStateProperty.all(10),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    link = await FlutterYoutubeDownloader.extractYoutubeLink(
                        urlController.text, itag);
                    if (link == "Failed to get iTag Url") {
                      setState(() {
                        error = "Invalid YouTube Url";
                      });

                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        error = "";
                      });
                    } else {
                      FlutterYoutubeDownloader.downloadVideo(
                          urlController.text.trim(), "Youtube Video", itag);
                    }
                  },
                ),
                Text(
                  error,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton qualityButton({required String quality}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        elevation: MaterialStateProperty.all(10),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 7, horizontal: 60),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: () {
        switch (quality) {
          case "360p":
            setState(() {
              itag = 18;
            });
            break;
          case "720p":
            setState(() {
              itag = 22;
            });
            break;
          case "1080p":
            setState(() {
              itag = 37;
            });
            break;
          default:
        }
      },
      child: Text(
        quality,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
