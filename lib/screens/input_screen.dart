// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hieroglyphs_name/models/hieroglyph_service.dart';
import 'package:hieroglyphs_name/screens/constants/app_images.dart';
import 'package:hieroglyphs_name/screens/constants/fonts.dart';
import 'package:hieroglyphs_name/screens/name_result.dart';
import 'package:url_launcher/url_launcher.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

Future<void> _launchWebsite() async {
  final Uri url = Uri.parse('https://www.egypttoursgroup.com');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}


class _InputScreenState extends State<InputScreen> {
  // void initState() {
  //   super.initState();
  //   final service = HieroglyphService();
  //   final letters = service.splitName("sherif");
  //   final images = service.getImages(letters);
  //   print(images);
  // }
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.background, fit: BoxFit.cover),
          ),

          Positioned(
            bottom: 0,
            top: 11,
            right: 1,
            left: 1,
            child: Image.asset(AppImages.dots),
          ),

          Positioned(
            bottom: 0,
            top: 11,
            child: Image.asset(AppImages.pyramids),
          ),

          Positioned(
            bottom: 0,
            top: 50,
            left: -10,

            child: Image.asset(AppImages.camel),
          ),
          Positioned(
            bottom: 0,
            top: 200,
            right: -100,
            left: -100,
            child: Image.asset(AppImages.grdbk, fit: BoxFit.cover),
          ),

          Positioned.fill(child: Container(color: Colors.black.withAlpha(20))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        "GET YOUR NAME",
                        style: TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 40,
                        ),
                      ),
                    ),

                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          "IN",
                          style: TextStyle(
                            fontSize: 38,
                            fontFamily: AppFonts.primary,
                          ),
                        ),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFFf5a931),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 0,
                            ),
                            child: Text(
                              "HIEROGLYPHS",
                              style: TextStyle(
                                fontSize: 38,
                                fontFamily: AppFonts.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),
                    SizedBox(
                      width: 340,
                      child: TextField(
                        controller: _nameController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontFamily: AppFonts.primary,
                        ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Color.fromARGB(255, 245, 171, 51),
                          hintText: "ENTER YOUR NAME ...",
                          hintStyle: TextStyle(color: Color(0xFFce8d2b)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xFF572d14),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xFF572d14),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
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
                          onTap: () {
                            final service = HieroglyphService();
                            final letters = service.splitName(
                              _nameController.text,
                            );
                            final Images = service.getImages(letters);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NameResult(
                                  images : Images ,
                                  name: _nameController.text,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            child: const Center(
                              child: Text(
                                "See your Cartouche",
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
                  ],
                ),
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
    );
  }
}
