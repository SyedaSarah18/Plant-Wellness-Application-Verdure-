import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:brew_crew/ui/screens/myPlantPage.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/constants.dart';
import 'package:brew_crew/models/plants.dart';
import 'package:brew_crew/ui/scan_page.dart';
import 'package:brew_crew/ui/screens/cart_page.dart';
import 'package:brew_crew/ui/screens/favorite_page.dart';
import 'package:brew_crew/ui/screens/home_page.dart';
import 'package:brew_crew/ui/screens/profile_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:brew_crew/screens/home/settings_form.dart';

import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];
  List<Plant> myPlant = [];

  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      FavoritePage(
        favoritedPlants: favorites,
      ),
      CartPage(
        addedToCartPlants: myCart,
      ),
      MyPlantPage(
        myPlants: myPlant,
      ),
      const ProfilePage(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.backpack_outlined,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Cart',
    'My Plants',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            TextButton.icon(
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: TextButton.styleFrom(
                primary: Colors.black.withOpacity(.5),
              ),
              onPressed: ()  {

              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchURL(context),
        child: Image.asset(
          'assets/images/code-scan-two.png',
          height: 30.0,
        ),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Constants.primaryColor,
          activeColor: Constants.primaryColor,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.end,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
              final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
              final List<Plant> addedToCartPlants = Plant.addedToCartPlants();
              final List<Plant> addedToMyPlants = Plant.addedToMyPlants();

              favorites = favoritedPlants;
              myCart = addedToCartPlants.toSet().toList();
              myPlant = addedToMyPlants.toSet().toList();
            });
          }),
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
