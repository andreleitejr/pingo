import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/services/blurhash_controller.dart';

class DesignImageGridView extends StatelessWidget {
  DesignImageGridView({Key? key, required this.isMasonry, this.onButtonPressed})
      : super(key: key);

  final bool isMasonry;
  final Function()? onButtonPressed;

  // TODO: Implementar imagens
  // final List<String> images;

  final images = <ImageBlurHash>[
    ImageBlurHash(
      image:
          'https://img.freepik.com/fotos-gratis/grupo-de-jovens-felizes-brindando-com-cerveja-e-se-divertindo-em-um-pub_637285-4057.jpg',
      blurHash: 'LUGRCyxt9a-:~VS#Rj-o9uR*xus.',
    ),
    ImageBlurHash(
      image:
          'https://media-cdn.tripadvisor.com/media/photo-s/1a/5d/f2/f6/autentico-pub-ingles.jpg',
      blurHash: 'LEDHpW^iEzI;}?-o%1R+5+t6%1%1',
    ),
    ImageBlurHash(
      image:
          'https://static.designmynight.com/uploads/2019/11/Fun-time-party-bars-belushi-optimised.jpg',
      blurHash: 'L9C?1WzU4,\$+Knvys8wN0KI.%gNL',
    ),
    ImageBlurHash(
      image:
          'https://media-cdn.tripadvisor.com/media/photo-s/16/49/7d/c7/house-of-beer-craft-beer.jpg',
      blurHash: 'L6G*HD~A00~WD~EjESv}5Y\$*IpNF',
    ),
    ImageBlurHash(
      image:
          'https://img.freepik.com/free-photo/confident-smiling-african-american-player-playing-boardgames-with-friends-home_482257-43285.jpg',
      blurHash: 'LVFYDZI9s:-;~pIToLx]xuRiX8Rk',
    ),
    ImageBlurHash(
      image: 'https://www.meon.com.br/source/files/originals/burger-526342.jpg',
      blurHash: 'LEHc+L}s4p9GBU-V4:57B;\$*=ZRP',
    ),
    ImageBlurHash(
      image: 'https://cdn.oimenu.com.br/base/79a/e7a/5fe/decoracao-pub.jpg',
      blurHash: 'L4ATAt=#00TZ01%F}rRR004.^*^j',
    ),
    ImageBlurHash(
      image:
          'https://media-cdn.tripadvisor.com/media/photo-s/1a/81/03/80/calabriao-deadpool-de.jpg',
      blurHash: 'L7Hd,4L#0[Pn9~#mSc9x4TxI-.NH',
    ),
    ImageBlurHash(
      image:
          'https://claudia.abril.com.br/wp-content/uploads/2020/07/pizza-pepperoni.jpg',
      blurHash: 'U5EK.PTB19tc5R69VY#;0kR5}U\$P[pxbAGXT',
    ),
    ImageBlurHash(
      image: 'https://fotos.web.sapo.io/i/Gc3189a6d/22334706_be71A.jpeg',
      blurHash: 'L9EorbW[00Vr05yD4:M_0K,@_Nx]',
    ),
    ImageBlurHash(
      image:
          'https://cdn.oimenu.com.br/base/0da/582/375/como-montar-um-pub.jpg',
      blurHash: 'CRH,O?={xZNy}=-ToJWC',
    ),
    ImageBlurHash(
      image: 'https://www.rbsdirect.com.br/imagesrc/35448575.jpg',
      blurHash: 'U9BVeF~BtkS#%hx]%2s9D,XTW?s+v}IoNG-U',
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

              return SizedBox(
                height: cardHeight,
                child: BlurHash(
                  hash: image.blurHash,
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
                hash: image.blurHash,
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
