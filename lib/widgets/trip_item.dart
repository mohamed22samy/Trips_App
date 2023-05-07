import 'package:flutter/material.dart';
import 'package:trips_app/screens/trip_detail_screen.dart';

import '../models/trip.dart';

class TripItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final TripType tripType;
  final Season season;
 

  TripItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.tripType,
      required this.season,
     });

  String? get seasonText {
    switch (season) {
      case Season.Winter:
        return 'شتاء';
        break;
      case Season.Spring:
        return 'ربيع';
        break;
      case Season.Summer:
        return 'صيف';
        break;
      case Season.Autumn:
        return 'خريف';
        break;
      default:
        'غير معروف';
    }
  }

  String? get tripTypeText {
    switch (tripType) {
      case TripType.Activities:
        return 'انشطه';
        break;
      case TripType.Exploration:
        return 'استكشاف';
        break;
      case TripType.Recovery:
        return 'استرخاء';
        break;
      case TripType.Therapy:
        return 'معالجه';
        break;
      default:
        'غير معروف';
    }
  }

  void selectTrip(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(TripDetailScreen.screenRoute, arguments: id)
        .then((result) {
      //then no work cause pop..
      if (result != null) {
      
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTrip(context),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 7,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            // to chose colers
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.8)
                        ],
                            stops: const [
                          //to tahakom
                          0.6,
                          1
                        ])),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    height: 250,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.fade, //to made nice headline..
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.today,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text("$duration ايام")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.wb_sunny,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(seasonText!)
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.family_restroom,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(tripTypeText!)
                        ],
                      )
                    ]),
              )
            ],
          )),
    );
  }
}
