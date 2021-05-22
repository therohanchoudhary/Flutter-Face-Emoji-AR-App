import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

const androidAPIkey =
    "68e87926b06719e66619bbbc03f47cb904aab003be628775d606d0ac0db6e8f7724386d3f025229f";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Sasta Snapchat'),
        ),
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  setState(() {});
                },
                onImageCaptured: (path) {
                  setState(() {});
                },
                onVideoRecorded: (path) {
                  setState(() {});
                },
                androidLicenceKey: androidAPIkey,
                iosLicenceKey: androidAPIkey,
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              if (isRecording) return;
                              cameraDeepArController.snapPhoto();
                            },
                            child: Icon(Icons.camera_enhance_outlined),
                            color: Colors.white,
                            padding: EdgeInsets.all(15),
                          ),
                        ),
                        if (isRecording)
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController.stopVideoRecording();
                                isRecording = false;
                                setState(() {});
                              },
                              child: Icon(Icons.videocam_off),
                              color: Colors.red,
                              padding: EdgeInsets.all(15),
                            ),
                          )
                        else
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController.startVideoRecording();
                                isRecording = true;
                                setState(() {});
                              },
                              child: Icon(Icons.videocam),
                              color: Colors.green,
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                      ],
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(7, (p) {
                          bool active = currentPage == p;
                          return GestureDetector(
                            onTap: () {
                              currentPage = p;
                              cameraDeepArController.changeMask(p);
                              setState(() {});
                            },
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(12),
                                width: active ? 100 : 80,
                                height: active ? 100 : 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        active ? Colors.orange : Colors.white,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "${p+1}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: active ? 16 : 14,
                                      color: Colors.black),
                                )),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
