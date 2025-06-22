import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supplyme_client/utils/vars.dart';
import 'package:vector_graphics/vector_graphics.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  TextEditingController promptController = TextEditingController();
  String errorMsg = "";

  void search() {
    setState(() { errorMsg = ""; });

    if (promptController.text.trim() == "") {
      setState(() { errorMsg = "Please enter a prompt"; });
      return;
    }

    setState(() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/results",
        (Route<dynamic> route) => false,
        arguments: {
          "prompt": promptController.text.trim()
        }
      );
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.4,
              child: AspectRatio(
                aspectRatio: 4,
                child: SvgPicture(
                  AssetBytesLoader('assets/images/logo.svg.vec'),
                  semanticsLabel: 'SupplyMe Logo',
                  fit: BoxFit.fitWidth,
                  clipBehavior: Clip.hardEdge
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "What do you want to look for?",
                style: TextStyle(
                  color: whiteColor,
                  fontFamily: "PlusJakartaSans",
                  fontSize: 22,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: errorMsg == "" ? 0 : 20),
              child: Text(
                errorMsg,
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: "PlusJakartaSans",
                  fontSize: errorMsg == "" ? 0 : 16,
                  fontWeight: FontWeight.w200
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: FractionallySizedBox(
                widthFactor: 0.75,
                child: TextField(
                  controller: promptController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    filled: true,
                    fillColor: whiteColor,
                    prefixIcon: Icon(
                      Icons.search
                    ),
                    prefixIconColor: blackColor,
                    hintText: "Search for a product...",
                    hintStyle: TextStyle(
                      fontFamily: "PlusJakartaSans",
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(35, 17, 35, 1)
                    ),
                  ),
                  cursorColor: blackColor,
                  style: TextStyle(
                    fontFamily: "PlusJakartaSans",
                    fontWeight: FontWeight.w400,
                    color: blackColor
                  ),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () { search(); },
              style: OutlinedButton.styleFrom(
                backgroundColor: brightPurpleColor,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                textStyle: TextStyle(
                  fontFamily: "PlusJakartaSans",
                  fontWeight: FontWeight.w400,
                  color: whiteColor
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0)
              ),
              child: Text(
                "Search",
                style: TextStyle(
                  fontFamily: "PlusJakartaSans",
                  fontWeight: FontWeight.w400,
                  color: whiteColor
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: blackColor,
    );
  }
}