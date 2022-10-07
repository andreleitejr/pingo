import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';

class DesignImageGridView extends StatelessWidget {
  DesignImageGridView({Key? key, required this.isMasonry, this.onButtonPressed})
      : super(key: key);

  final bool isMasonry;
  final Function()? onButtonPressed;

  // TODO: Implementar imagens
  // final List<String> images;

  final images = <String>[
    'https://img.freepik.com/fotos-gratis/grupo-de-jovens-felizes-brindando-com-cerveja-e-se-divertindo-em-um-pub_637285-4057.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/1a/5d/f2/f6/autentico-pub-ingles.jpg',
    'https://static.designmynight.com/uploads/2019/11/Fun-time-party-bars-belushi-optimised.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/16/49/7d/c7/house-of-beer-craft-beer.jpg',
    'https://img.freepik.com/free-photo/confident-smiling-african-american-player-playing-boardgames-with-friends-home_482257-43285.jpg',
    'https://www.meon.com.br/source/files/originals/burger-526342.jpg',
    'https://cdn.oimenu.com.br/base/79a/e7a/5fe/decoracao-pub.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/1a/81/03/80/calabriao-deadpool-de.jpg',
    'https://claudia.abril.com.br/wp-content/uploads/2020/07/pizza-pepperoni.jpg',
    'https://fotos.web.sapo.io/i/Gc3189a6d/22334706_be71A.jpeg',
    'https://cdn.oimenu.com.br/base/0da/582/375/como-montar-um-pub.jpg',
    'https://www.rbsdirect.com.br/imagesrc/35448575.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isMasonry) ...[
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemCount: images.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final mediumCardWidth = Get.width * 0.75;
              final smallCardWidth = Get.width * 0.5;
              final cardHeight =
                  index % 2 == 0 ? mediumCardWidth : smallCardWidth;

              final image = images[index];

              return Container(
                height: cardHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )
        ] else ...[
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            children: List.generate(images.length, (index) {
              final image = images[index];
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ],
        Positioned(
          bottom: DesignSize.mediumSpace,
          right: DesignSize.mediumSpace,
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
                shape: const CircleBorder(),
              ),
              onPressed: onButtonPressed,
              child: const Icon(
                Icons.grid_on_outlined,
                color: DesignColor.primary500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
