import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trips_app/screens/filter_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/constant.dart';

class AppDrawer extends StatelessWidget {
  void rateApp() async {
    //rate fanction to usefull..
    if (!await launchUrl(rateUriApp, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $rateUriApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildListTile({
      required IconData icon,
      required String title,
      required Function() onTapLink,
    }) {
      return ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: "ElMessiri",
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        onTap: onTapLink,
      );
    }

    void shareApp() {
      //share fanction to usefull..
      Share.share(
          '''*Trips App*\n you can Enquiry it from my facebook facebook.com/Mohamed Elshora ''');
      Navigator.pop(context);
    }

    return Drawer(
      child: Column(children: [
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 40),
          alignment: Alignment.center,
          color:KscoundColor,
          child: Text(
            "دليلك السياحي",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildListTile(
            title: "الرحلات",
            icon: Icons.card_travel,
            onTapLink: () {
              Navigator.of(context).pushReplacementNamed(
                  "/"); //use pushReplacementNamed to delete the after page.
            }),
        buildListTile(
            title: "الفلتره",
            icon: Icons.filter_list,
            onTapLink: () {
              Navigator.of(context).pushReplacementNamed(FilterScreen
                  .screenRoute); //use pushReplacementNamed to delete the after page.
            }),
        buildListTile(
            title: "تقيم",
            icon: Icons.rate_review,
            onTapLink: rateApp), //use rate function
        buildListTile(
            title: "مشاركه",
            icon: Icons.share,
            onTapLink: shareApp), //use share function
      ]),
    );
  }
}
