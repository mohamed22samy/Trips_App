import 'package:flutter/material.dart';
import 'package:trips_app/models/trip.dart';

import '../widgets/trip_item.dart';

class FavoratesScreen extends StatelessWidget {
  static const screenRoute = '/favorate_screen';

  final List<Trip> favorateTrips;

   FavoratesScreen( this.favorateTrips);

  @override
  Widget build(BuildContext context) {
    if(favorateTrips.isEmpty){
       return Center(
      child: Text("صفحه المفضله فارغههههه"),
    );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
              id: favorateTrips[index].id,
              title: favorateTrips[index].title,
              imageUrl: favorateTrips[index].imageUrl,
              duration: favorateTrips[index].duration,
              tripType: favorateTrips[index].tripType,
              season: favorateTrips[index].season,
             );
        },
        itemCount: favorateTrips.length,
      );
    }
   
  }
}
