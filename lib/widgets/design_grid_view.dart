import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';

class DesignBlurHashImage {
  final String image;
  final String hash;

  DesignBlurHashImage({required this.image, required this.hash});
}

class DesignImageGridView extends StatelessWidget {
  DesignImageGridView({Key? key, required this.isMasonry, this.onButtonPressed})
      : super(key: key);

  final bool isMasonry;
  final Function()? onButtonPressed;

  // TODO: Implementar imagens
  // final List<String> images;

  final images = <DesignBlurHashImage>[
    DesignBlurHashImage(
      image:
          'https://img.freepik.com/fotos-gratis/grupo-de-jovens-felizes-brindando-com-cerveja-e-se-divertindo-em-um-pub_637285-4057.jpg',
      hash: 'LUGRCyxt9a-:~VS#Rj-o9uR*xus.',
    ),
    DesignBlurHashImage(
      image:
          'https://media-cdn.tripadvisor.com/media/photo-s/1a/5d/f2/f6/autentico-pub-ingles.jpg',
      hash: 'LEDHpW^iEzI;}?-o%1R+5+t6%1%1',
    ),
    DesignBlurHashImage(
      image:
          'https://static.designmynight.com/uploads/2019/11/Fun-time-party-bars-belushi-optimised.jpg',
      hash: 'L9C?1WzU4,\$+Knvys8wN0KI.%gNL',
    ),
    DesignBlurHashImage(
      image:
          'https://media-cdn.tripadvisor.com/media/photo-s/16/49/7d/c7/house-of-beer-craft-beer.jpg',
      hash: 'L6G*HD~A00~WD~EjESv}5Y\$*IpNF',
    ),
    DesignBlurHashImage(
      image:
          'https://img.freepik.com/free-photo/confident-smiling-african-american-player-playing-boardgames-with-friends-home_482257-43285.jpg',
      hash: 'LVFYDZI9s:-;~pIToLx]xuRiX8Rk',
    ),
    DesignBlurHashImage(
      image: 'https://www.meon.com.br/source/files/originals/burger-526342.jpg',
      hash: 'LEHc+L}s4p9GBU-V4:57B;\$*=ZRP',
    ),
    DesignBlurHashImage(
      image: 'https://cdn.oimenu.com.br/base/79a/e7a/5fe/decoracao-pub.jpg',
      hash: 'L4ATAt=#00TZ01%F}rRR004.^*^j',
    ),
    DesignBlurHashImage(
      image:
          'https://media-cdn.tripadvisor.com/media/photo-s/1a/81/03/80/calabriao-deadpool-de.jpg',
      hash: 'L7Hd,4L#0[Pn9~#mSc9x4TxI-.NH',
    ),
    DesignBlurHashImage(
      image:
          'https://claudia.abril.com.br/wp-content/uploads/2020/07/pizza-pepperoni.jpg',
      hash: 'U5EK.PTB19tc5R69VY#;0kR5}U\$P[pxbAGXT',
    ),
    DesignBlurHashImage(
      image: 'https://fotos.web.sapo.io/i/Gc3189a6d/22334706_be71A.jpeg',
      hash: 'L9EorbW[00Vr05yD4:M_0K,@_Nx]',
    ),
    DesignBlurHashImage(
      image:
          'https://cdn.oimenu.com.br/base/0da/582/375/como-montar-um-pub.jpg',
      hash: 'CRH,O?={xZNy}=-ToJWC',
    ),
    DesignBlurHashImage(
      image: 'https://www.rbsdirect.com.br/imagesrc/35448575.jpg',
      hash: 'U9BVeF~BtkS#%hx]%2s9D,XTW?s+v}IoNG-U',
    ),
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
                child: BlurHash(
                  hash: image.hash,
                  image: image.image,
                  imageFit: BoxFit.cover,
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
              return BlurHash(
                hash: image.hash,
                image: image.image,
                imageFit: BoxFit.cover,
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
