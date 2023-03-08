import 'package:flutter/material.dart';
// import 'package:flutter_onboarding/constants.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Welcome to plant doctor'),
          onPressed: () => _launchURL(context),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        'https://sulphatet-leaves-doctor-stream-app-s2chum.streamlit.app/',
        customTabsOption: CustomTabsOption(
          toolbarColor: Colors.greenAccent,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: false,
          // animation: CustomTabsAnimation.slideIn(),
          // // or user defined animation.
          // animation: const CustomTabsAnimation(
          //   startEnter: 'slide_up',
          //   startExit: 'android:anim/fade_out',
          //   endEnter: 'android:anim/fade_in',
          //   endExit: 'slide_down',
          // ),
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
