import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/features/event/pages/list/event_list_page.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/home/home_page.dart';
import 'package:pingo/features/place/pages/list/place_list_page.dart';
import 'package:pingo/features/product/pages/list/product_list_page.dart';
import 'package:pingo/features/profile/read/profile_read_page.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_read_image.dart';

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
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: DesignIcon(
                icon: DesignIcons.home,
                isLoading: controller.loading.value,
              ),
              activeIcon: DesignIcon(
                icon: DesignIcons.home,
                isSelected: true,
                isLoading: controller.loading.value,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: DesignIcon(
                icon: DesignIcons.map,
                isLoading: controller.loading.value,
              ),
              activeIcon: DesignIcon(
                icon: DesignIcons.map,
                isSelected: true,
                isLoading: controller.loading.value,
              ),
              label: 'Places',
            ),
            BottomNavigationBarItem(
              icon: DesignIcon(
                icon: DesignIcons.event,
                isLoading: controller.loading.value,
              ),
              activeIcon: DesignIcon(
                icon: DesignIcons.event,
                isSelected: true,
                isLoading: controller.loading.value,
              ),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: DesignIcon(
                icon: DesignIcons.product,
                isLoading: controller.loading.value,
              ),
              activeIcon: DesignIcon(
                icon: DesignIcons.product,
                isSelected: true,
                isLoading: controller.loading.value,
              ),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: DesignAvatarImage(
                image: controller.user.image?.image,
                isLoading: controller.loading.value,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
