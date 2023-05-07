import 'package:flutter/material.dart';
import 'package:trips_app/app_data.dart';
import 'package:trips_app/models/trip.dart';

class TripDetailScreen extends StatelessWidget {
  static const screenRoute = '/trip_detail';

  final Function manageFavorate;
  final Function isFavorate;
  TripDetailScreen(this.manageFavorate, this.isFavorate);

  Widget buildSetionTitle(BuildContext context, String titleText) {
    //methode
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildListViewContaner(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 200,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)!.settings.arguments as String;
    // ignore: unused_local_variable
    final selectedTrip = Trips_data.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedTrip.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedTrip.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            buildSetionTitle(context, 'الانشطه:'), //method
            buildListViewContaner(
              ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                      elevation: 0.4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(selectedTrip.activities[index]),
                      )),
                  itemCount: selectedTrip.activities.length),
            ),
            const SizedBox(height: 10),
            buildSetionTitle(context, 'االبرنامج اليومي:'), //method
            buildListViewContaner(ListView.builder(
              itemBuilder: (ctx, index) => Column(children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text("يوم${index + 1}")),
                  title: Text(selectedTrip.program[index]),
                ),
                const Divider()
              ]),
              itemCount: selectedTrip.program.length,
            )),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()=>
            manageFavorate(tripId)
          ,
          child: Icon(isFavorate(tripId) ? Icons.star : Icons.star_border)),
    );
  }
}
