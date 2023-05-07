import 'package:flutter/material.dart';
import 'package:trips_app/screens/categories_screen.dart';
import 'package:trips_app/widgets/app_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const screenRoute = '/filter_screen';

  final Function saveFilter;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilter);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _summer = false;

  var _winter = false;

  var _family = false;

  @override
  void initState() {
    _summer = widget.currentFilters["summer"]!;
    _winter = widget.currentFilters["winter"]!;
    _family = widget.currentFilters["family"]!;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String subtitle, var currentValue,
      Function(bool)? updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحه الفلتره"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilter = {
                  "summer": _summer,
                  "winter": _winter,
                  "family": _family,
                };
                widget.saveFilter(selectedFilter);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: AppDrawer(),
      body: Column(children: [
        const SizedBox(height: 50),
        Expanded(
          child: ListView(children: [
            buildSwitchListTile(
              "الرحلات الصيفيه",
              "  اظهار الرحلات الخاصه بالصيف ",
              _summer,
              (newValue) {
                setState(() {
                  _summer = newValue;
                });
              },
            ),
            buildSwitchListTile(
              "الرحلات الشتويه",
              "  اظهار الرحلات الخاصه بالشتاء ",
              _winter,
              (newValue) {
                setState(() {
                  _winter = newValue;
                });
              },
            ),
            buildSwitchListTile(
              "الرحلات الخاصه بالعائلات",
              "  اظهار الرحلات الخاصه بالعائلات ",
              _family,
              (newValue) {
                setState(() {
                  _family = newValue;
                });
              },
            )
          ]),
        )
      ]),
    );
  }
}
