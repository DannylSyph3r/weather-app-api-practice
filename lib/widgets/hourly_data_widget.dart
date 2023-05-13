import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_watch/model/weather_data_hourly.dart';
import 'package:weather_watch/utils/custom_colors.dart';
import '../controller/global_controller.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});


  // Card Index
  RxInt cardIndex = GlobalController().getIndex();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text("Today", style:TextStyle(fontSize: 18)),
        ),
        hourlyList(),
      ],
    );
  } 

  Widget hourlyList(){
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12 ? 14: weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx ((() => GestureDetector(
            onTap: (){
              cardIndex.value = index;
            },
            child: Container(
            width: 90,
            margin: const EdgeInsets.only(left: 20, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(offset: const Offset(0.5,0), blurRadius: 30, spreadRadius: 1, color: CustomColors.dividerLine.withAlpha(150))
              ],
              gradient: cardIndex.value == index ? const LinearGradient(colors: [
                CustomColors.firstGradientColor,
                  CustomColors.secondGradientColor,
              ])
              : null),
              child: HourlyDetails(
                index: index,
                cardIndex: cardIndex.toInt(),
                temp: weatherDataHourly.hourly[index].temp!,
                timeStamp: weatherDataHourly.hourly[index].dt!,
                weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
              ),
          ))));
        },
        ),      
    );
  }
}




// Hourly Details Class
  class HourlyDetails extends StatelessWidget {
    int temp;
    int index;
    int cardIndex;
    int timeStamp;
    String weatherIcon;

    HourlyDetails ({super.key, required this.temp, required this.timeStamp, required this.weatherIcon, required this.index, required this.cardIndex});
    
    String getTime(final timeStamp) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      String x = DateFormat('jm').format(time);
      return x;
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(top:10),
            child: Text(getTime(timeStamp), 
            style: TextStyle(
              color: cardIndex == index 
              ? Colors.white
              : CustomColors.textColorBlack)),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Image.asset("assets/weather/$weatherIcon.png", 
            height: 40, 
            width: 40,
            )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text("$temp°C", 
            style: TextStyle(
              color: cardIndex == index 
              ? Colors.white
              : CustomColors.textColorBlack)),
            ),
        ],
      );
    }
  }