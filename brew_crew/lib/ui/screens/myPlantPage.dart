import 'package:flutter/material.dart';
import 'package:brew_crew/constants.dart';
import 'package:brew_crew/models/plants.dart';
import 'package:brew_crew/ui/screens/widgets/plant_widget.dart';

class MyPlantPage extends StatefulWidget {
  final List<Plant> myPlants;
  const MyPlantPage({Key? key, required this.myPlants}) : super(key: key);

  @override
  State<MyPlantPage> createState() => _MyPlantPageState();
}

class _MyPlantPageState extends State<MyPlantPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: widget.myPlants.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/plantpot.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Plants',
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              height: size.height * .5,
              child: ListView.builder(
                  itemCount: widget.myPlants.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return PlantWidget(
                        index: index, plantList: widget.myPlants);
                  }),
            ),
    );
  }
}
