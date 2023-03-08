import 'package:flutter/material.dart';
import 'package:brew_crew/constants.dart';
import 'package:brew_crew/constants.dart';
import 'package:brew_crew/models/plants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import '../scan_page.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  const DetailPage({Key? key, required this.plantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  //Toggle add remove from cart
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  //Toggle add remove from cart
  bool toggleIsMyPlant(bool isMyPlant) {
    return !isMyPlant;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.primaryColor.withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('favorite');
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.primaryColor.withOpacity(.15),
                    ),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            bool isFavorited = toggleIsFavorated(
                                _plantList[widget.plantId].isFavorated);
                            _plantList[widget.plantId].isFavorated =
                                isFavorited;
                          });
                        },
                        icon: Icon(
                          _plantList[widget.plantId].isFavorated == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Constants.primaryColor,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 350,
                      child: Image.asset(_plantList[widget.plantId].imageURL),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeature(
                            title: 'Size',
                            plantFeature: _plantList[widget.plantId].size,
                          ),
                          PlantFeature(
                            title: 'Humidity',
                            plantFeature:
                                _plantList[widget.plantId].humidity.toString(),
                          ),
                          PlantFeature(
                            title: 'Temperature',
                            plantFeature:
                                _plantList[widget.plantId].temperature,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _plantList[widget.plantId].plantName,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            r'₹' + _plantList[widget.plantId].price.toString(),
                            style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _plantList[widget.plantId].rating.toString(),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Constants.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 30.0,
                            color: Constants.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      _plantList[widget.plantId].decription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: Constants.blackColor.withOpacity(.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                  onPressed: () =>
                      _launchURL(context, _plantList[widget.plantId]),
                  // onPressed: () {
                  //   Navigator.push(
                  //       context,
                  //       PageTransition(
                  //           child: const ArPlant(),
                  //           // child: ObjectsOnPlanesWidget(),
                  //           type: PageTransitionType.bottomToTop));
                  // },
                  icon: Icon(
                    Icons.view_in_ar_rounded,
                    color: Constants.primaryColor,
                  )),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Constants.primaryColor.withOpacity(.3),
                    ),
                  ]),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      bool isSelected = toggleIsSelected(
                          _plantList[widget.plantId].isSelected);

                      _plantList[widget.plantId].isSelected = isSelected;
                    });
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: _plantList[widget.plantId].isSelected == true
                        ? Colors.white
                        : Constants.primaryColor,
                  )),
              decoration: BoxDecoration(
                  color: _plantList[widget.plantId].isSelected == true
                      ? Constants.primaryColor.withOpacity(.5)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Constants.primaryColor.withOpacity(.3),
                    ),
                  ]),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Constants.primaryColor.withOpacity(.3),
                      )
                    ]),
                child: const Center(
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ElevatedButton(
                  child: Text('Add to my list'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    side: BorderSide(width: 3),
                  ),
                  onPressed: () {
                    bool isMyPlant =
                        toggleIsMyPlant(_plantList[widget.plantId].isMyPlant);
                    _plantList[widget.plantId].isMyPlant = isMyPlant;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, Plant plantList) async {
    try {
      print(plantList.plantId);
      if ((plantList.plantId == 0) || (plantList.plantId == 3)) {
        await launch(
          'https://lovely-peat-flea.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 1) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 2) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 4) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 5) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 6) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 7) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
      if (plantList.plantId == 8) {
        await launch(
          'https://rebel-nutritious-brook.glitch.me/',
          customTabsOption: CustomTabsOption(
            toolbarColor: Colors.greenAccent,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: false,
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
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
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
