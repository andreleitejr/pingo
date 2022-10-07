import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/features/event/pages/list/event_list_page.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/home/home_page.dart';
import 'package:pingo/features/place/pages/list/place_list_page.dart';
import 'package:pingo/features/product/pages/list/product_list_page.dart';
import 'package:pingo/features/profile/read/profile_read_page.dart';
import 'package:pingo/models/user.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final controller = Get.put(HomeController());
  final User user = Get.find();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Get.find();
    final pages = <Widget>[
      HomePage(),
      PlaceListPage(places: controller.places, showLeading: false),
      EventListPage(events: controller.eventsBestMatch, showLeading: false),
      ProductListPage(
          products: controller.productBestMatch, showLeading: false),
      ProfileReadPage(),
    ];

    return Scaffold(
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: DesignColor.text300,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.place,
              color: DesignColor.text300,
            ),
            label: 'Places',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: DesignColor.text300,
            ),
            label: 'Events',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
              color: DesignColor.text300,
            ),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: DesignColor.primary500,
                borderRadius: BorderRadius.circular(48),
                image: user.image != null
                    ? DecorationImage(
                        image: NetworkImage(user.image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
