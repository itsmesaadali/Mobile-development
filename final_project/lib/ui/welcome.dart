import 'package:final_project/models/city.dart';
import 'package:final_project/models/constants.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    List<City> cities = City.citiesList
        .where((city) => city.isDefault == false)
        .toList();
    List<City> selectedCities = City.getSelectedCities();

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        title: Text(selectedCities.length.toString() + ' selected'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.8,
            width: size.width,
            decoration: BoxDecoration(
              border: cities[index].isSelected == true
                  ? Border.all(
                      color: myConstants.secondaryColor.withValues(alpha: 0.6),
                      width: 2,
                    )
                  : Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: myConstants.primaryColor.withValues(alpha: 0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  cities[index].isSelected == true
                      ? 'assets/checked.png'
                      : 'assets/unchecked.png',
                  width: 30,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
