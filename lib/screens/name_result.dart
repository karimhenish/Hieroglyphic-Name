import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hieroglyphs_name/screens/constants/app_images.dart';
import 'package:hieroglyphs_name/screens/constants/fonts.dart';
import 'package:hieroglyphs_name/screens/input_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NameResult extends StatefulWidget {
  final List<String> images;
  final String name;
  const NameResult({super.key, required this.images, required this.name});

  @override
  State<NameResult> createState() => _NameResultState();
}

Future<void> _launchWebsite() async {
  final Uri url = Uri.parse('https://www.egypttoursgroup.com');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

class _NameResultState extends State<NameResult> {
  final GlobalKey imageKey = GlobalKey();
  bool _showButtons = true;

  @override
  Widget build(BuildContext context) {
    double cartouchWidth = MediaQuery.of(context).size.width * 0.9;
    double avilableWidth = cartouchWidth - 40;
    double symbolSize = avilableWidth / widget.images.length;
    int symbolsCount = widget.images.length;
    double totalSymbolsWidth = symbolsCount * symbolSize;
    double remainingSpace = avilableWidth - totalSymbolsWidth;
    double spacing = 0;
    if (symbolsCount > 1) {
      spacing = remainingSpace / (symbolsCount - 1);
    }
    if (symbolSize > 60) {
      symbolSize = 60;
    }

    if (symbolSize < 18) {
      symbolSize = 18;
    }

    List<Widget> symbol = [];
    for (int i = 0; i < widget.images.length; i++) {
      symbol.add(
        Image.asset(
          widget.images[i],
          width: symbolSize,
          height: symbolSize,
          fit: BoxFit.contain,
        ),
      );

      if (i != widget.images.length - 1) {
        symbol.add(SizedBox(width: spacing));
      }
    }
    double writingArea = cartouchWidth * 0.72;
    return Scaffold(
      body: RepaintBoundary(
        key: imageKey,

        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppImages.background, fit: BoxFit.cover),
            ),
            // Positioned(bottom: 0, top: 0, child: Image.asset(AppImages.cartouch)),
            Positioned(
              bottom: 0,
              top: 200,
              right: -100,
              left: -100,
              child: Image.asset(AppImages.grdbk, fit: BoxFit.cover),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Column(
                      children: [
                        Text(
                          "From Egypt with love",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: AppFonts.primary,
                          ),
                        ),
                        SizedBox(
                          width: cartouchWidth,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                AppImages.cartouch,
                                fit: BoxFit.contain,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                ),

                                child: SizedBox(
                                  width: writingArea,

                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,

                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: symbol,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${widget.name.toUpperCase()} in HIEROGLYPHS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: AppFonts.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    if (_showButtons) ...[
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFc0a26e), Color(0xFF9b6c43)],
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(13),
                            onTap: () async {
                              // إخفاء الأزرار
                              setState(() {
                                _showButtons = false;
                              });

                              await WidgetsBinding.instance.endOfFrame;

                              RenderRepaintBoundary boundary =
                                  imageKey.currentContext!.findRenderObject()
                                      as RenderRepaintBoundary;

                              ui.Image image = await boundary.toImage(
                                pixelRatio: 3,
                              );

                              ByteData? byteData = await image.toByteData(
                                format: ui.ImageByteFormat.png,
                              );

                              Uint8List pngBytes = byteData!.buffer
                                  .asUint8List();

                              final directory = await getTemporaryDirectory();
                              final file = File(
                                '${directory.path}/EgyptToursGroup.png',
                              );

                              await file.writeAsBytes(pngBytes);

                              setState(() {
                                _showButtons = true;
                              });

                              await Share.shareXFiles([
                                XFile(file.path),
                              ], text: 'My name in Hieroglyphs');
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 50,
                              child: const Center(
                                child: Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: AppFonts.primary,
                                    color: Color(0xFF582d13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(13),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InputScreen(),
                              ),
                            );
                          },
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFc0a26e), Color(0xFF9b6c43)],
                              ),
                            ),
                            child: const Text(
                              "Try Again",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: AppFonts.primary,
                                color: Color(0xFF582d13),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            Center(
              child: Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppImages.logo, width: 80),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                "Powered By ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "EGYPT TOURS GROUP ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await _launchWebsite();
                            },

                            child: Text(
                              "WWW.EGYPTTOURSGROUP.COM",
                              style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
