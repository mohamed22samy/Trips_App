import 'package:flutter/material.dart';
import 'package:trips_app/models/constant.dart';
import 'package:trips_app/models/trip.dart';
import 'package:trips_app/screens/categories_screen.dart';
import 'package:trips_app/widgets/app_drawer.dart';

import 'favorates_screen.dart';

// class TabsScreen extends StatelessWidget {
//   const TabsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text("دليلك السياحي"),
//             bottom: const TabBar(tabs: [
//               Tab(
//                 icon: Icon(Icons.dashboard),
//                 text: "التصنيفات",
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: "المفضله",
//               )
//             ]),
//           ),
//           body:  TabBarView(children: [
//             CategoriesScreen(),
//             FavoratesScreen(),
//           ]),
//         ));
//   }
// }

class TabsScreen extends StatefulWidget {
  final List<Trip> favorateTrips;

  TabsScreen(this.favorateTrips);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  int _selectedScreenIndex = 0;

   List<Map<String, Widget>>? _screen;
   @override
  void initState() {
    _screen = [
    {"Screen": CategoriesScreen(), "Title": Text("تصنيفات الرحلات")},
    {"Screen": FavoratesScreen(widget.favorateTrips), "Title": Text("الرحلات المفضله")},
  ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _screen![_selectedScreenIndex]["Title"],
      ),
      drawer: AppDrawer(),
      body: _screen![_selectedScreenIndex]["Screen"],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: KscoundColor,
          currentIndex: _selectedScreenIndex, //page now
          onTap: _selectedScreen,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: "التصنيفات"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "المفضله")
          ]),
    );
  }
}
