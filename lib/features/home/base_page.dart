import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/features/event/pages/list/event_list_page.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/home/home_page.dart';
import 'package:pingo/features/place/pages/list/place_list_page.dart';
import 'package:pingo/features/product/pages/list/product_list_page.dart';
import 'package:pingo/features/profile/read/profile_read_page.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_error_page.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_read_image.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> implements BasePageNav {
  late HomeController controller;
  final User user = Get.find();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    controller = Get.put(HomeController(this));
    super.initState();
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

  @override
  void locationDenied() {
    Get.to(
      () => DesignErrorPage(
        title: 'Localização negada',
        description:
            'Acesso à localização negado. Dessa forma, não conseguimos encontrar os melhores lugares próximos. Por favor, vá até suas configurações e permita que o Pingo saiba sua localização atual.',
        image: DesignImages.fallbackImage,
        onPressed: () => AppSettings.openLocationSettings(),
      ),
    );
  }

  @override
  void noInternetConnection() {
    Get.to(
      () => DesignErrorPage(
        title: 'Sem conexão com a internet',
        description:
            'Parece que você está desconectado. Dessa forma, não conseguimos encontrar os melhores lugares próximos. Por favor, verifique suas configurações e o status de conexão.',
        image: DesignImages.fallbackImage,
        onPressed: () => AppSettings.openDataRoamingSettings(),
      ),
    );
  }
}

abstract class BasePageNav {
  void locationDenied();

  void noInternetConnection();
}
