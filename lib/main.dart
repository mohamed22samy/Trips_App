import 'package:flutter/material.dart';
import 'package:trips_app/app_data.dart';
import 'package:trips_app/screens/categories_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trips_app/screens/category_trips_screen.dart';
import 'package:trips_app/screens/favorates_screen.dart';
import 'package:trips_app/screens/filter_screen.dart';
import 'package:trips_app/screens/tabs_screen.dart';
import 'package:trips_app/screens/trip_detail_screen.dart';

import 'models/trip.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  List<Trip> _favoriteTrips = [];

  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableTrips = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex =
        _favoriteTrips.indexWhere((trip) => trip.id == tripId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrips.add(
          Trips_data.firstWhere((trip) => trip.id == tripId),
        );
      });
    }
  }

  bool _isFovarite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // arabic , country code
      ],
      debugShowCheckedModeBanner: false,
      title: 'Trips App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline5: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri'),
              headline6: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri'))),
      // home: const CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteTrips),
        FilterScreen.screenRoute: (ctx) =>
            FilterScreen(_filters, _changeFilters),
        CategoriesScreen.screenRoute: (ctx) => CategoriesScreen(),
        CategoryTrips.screenRoute: (ctx) => CategoryTrips(_availableTrips),
        TripDetailScreen.screenRoute: (ctx) =>
            TripDetailScreen(_manageFavorite, _isFovarite),
      },
    );
  }
}
