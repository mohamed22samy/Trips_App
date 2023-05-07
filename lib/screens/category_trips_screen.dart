import 'package:flutter/material.dart';
import 'package:trips_app/models/trip.dart';
import 'package:trips_app/widgets/trip_item.dart';

import '../app_data.dart';

class CategoryTrips extends StatefulWidget {
  static const screenRoute = '/category-trips';
  List<Trip> availableTrips;

  CategoryTrips(this.availableTrips);

  @override
  State<CategoryTrips> createState() => _CategoryTripsState();
}

class _CategoryTripsState extends State<CategoryTrips> {
  String? categoryTitle;
  List<Trip>? displayTrips;

  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //to fixed context error..
    final routeArgument =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // ignore: unused_local_variable
    final categoryId = routeArgument['id'];
    categoryTitle = routeArgument['title'];
    displayTrips = widget.availableTrips.where((trip) {
      //filter to trips cause categories = categoryId
      return trip.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeTrip(String tripId) {
    setState(() {
      displayTrips!.removeWhere((trip) => trip.id == tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
              id: displayTrips![index].id,
              title: displayTrips![index].title,
              imageUrl: displayTrips![index].imageUrl,
              duration: displayTrips![index].duration,
              tripType: displayTrips![index].tripType,
              season: displayTrips![index].season,
             );
        },
        itemCount: displayTrips!.length,
      ),
    );
  }
}
