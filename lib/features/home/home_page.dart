import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/models/address.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_vertical_space.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.keywords}) : super(key: key);

  final List<KeywordData> keywords;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    print('################### KEYWORDS: ${widget.keywords}');
    controller = Get.put(HomeController(widget.keywords));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(),
        ),
        body: Column(
          children: [
            const DesignVerticalSpace(),
            Text('Keywords: '),
            Obx(
              () => Text(
                controller.keywordsIds.toString(),
              ),
            ),
            const DesignVerticalSpace(),
            Text('Places: '),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.bestMatch.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: [
                      Text(
                        controller.bestMatch[index].name,
                      ),
                      Text(
                        controller.bestMatch[index].keywords.toString(),
                      ),
                      Text(
                        'Match: ${controller.bestMatch[index].match}',
                      ),
                      const DesignVerticalSpace(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  final placeRepository = PlaceRepository();

                  final keywords = [
                    Keyword.restaurant,
                    Keyword.pub,
                    Keyword.theater,
                    Keyword.beer,
                    Keyword.art,
                  ];
                  final place = Place(
                    name: 'Estação Satyros',
                    description: '$keywords',
                    address: addresses[0],
                    createdBy: 'LBq1jxC7ZauF91cDEipT',
                    open: 10,
                    close: 22,
                    email: 'contato@teste.com',
                    image:
                        'https://seeklogo.com/images/C/China_In_Box-logo-2381EFC72D-seeklogo.com.png',
                    keywords: keywords,
                  );
                  placeRepository.save(place);
                  // final productRepository = ProductRepository();
                  // final product = Product(
                  //   price: 39.90,
                  //   placeId:,
                  //   name: 'Pizza de Pepperoni',
                  //   description:
                  //   'Deliciosa massa da casa com queijo mussarela de primeira qualidade, azeitonas, tomates e orégano.',
                  //   createdBy: 'LBq1jxC7ZauF91cDEipT',
                  // );
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ));
  }
}
