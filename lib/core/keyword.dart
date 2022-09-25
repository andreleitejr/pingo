class KeywordData {
  final String title;
  final int id;

  KeywordData(this.title, this.id);
}

class Keyword {
  /// TYPES OF PLACES
  static const restaurant = 1;
  static const pub = 2;
  static const party = 3;
  static const concert = 4;
  static const park = 5;
  static const museum = 6;
  static const square = 7;
  static const cinema = 8;
  static const historical = 9;
  static const theater = 10;
  static const bookstore = 11;
  static const exposition = 12;

  /// TYPES OF FOOD
  static const brazilian = 13;
  static const fastFood = 14;
  static const pizza = 15;
  static const burger = 16;
  static const hotDog = 17;
  static const candy = 18;
  static const donuts = 19;
  static const japanese = 20;
  static const mexican = 21;
  static const chinese = 22;
  static const italian = 23;
  static const thai = 24;
  static const greek = 25;
  static const arabian = 26;
  static const coxinha = 27;
  static const marmita = 28;
  static const pastel = 29;
  static const esfiha = 30;

  /// TYPES OF MUSIC
  static const rock = 31;
  static const pop = 32;
  static const country = 33;
  static const electronic = 34;
  static const funk = 35;
  static const house = 36;
  static const trap = 37;
  static const techno = 38;
  static const rap = 39;
  static const samba = 40;
  static const metal = 41;
  static const pagode = 42;
  static const gospel = 43;
  static const classic = 44;
  static const mpb = 45;
  static const blues = 46;
  static const jazz = 47;
  static const trance = 48;
  static const hardcore = 49;
  static const punk = 50;

  /// MISCELLANEOUS
  static const gym = 51;
  static const beer = 52;
  static const sports = 53;
  static const games = 54;
  static const dance = 55;
  static const anime = 56;
  static const chocolate = 57;
  static const streetArt = 58;
  static const bike = 59;
  static const skate = 60;
  static const rollerblades = 61;
  static const art = 62;
  static const tattoo = 63;
  static const meditation = 64;
  static const soccer = 65;
  static const basketball = 66;
  static const volleyball = 67;
  static const tennis = 68;
  static const ufc = 69;
  static const boxing = 70;
  static const bjj = 71;
  static const thaiBoxing = 72;
  static const gin = 73;
  static const scotch = 74;
  static const drinks = 75;
  static const soda = 76;

  /// SEXUAL ORIENTATION
  static const lgbt = 99;

  /// SEXUAL ORIENTATION
  static const police = 190;
  static const emergency = 191;
  static const hospital = 192;
  static const fireDepartment = 193;
}

final places = <KeywordData>[
  KeywordData('Restaurant', Keyword.restaurant),
  KeywordData('Pub', Keyword.pub),
  KeywordData('Party', Keyword.party),
  KeywordData('Concert', Keyword.concert),
  KeywordData('Park', Keyword.park),
  KeywordData('Museum', Keyword.museum),
  KeywordData('Square', Keyword.square),
  KeywordData('Historical', Keyword.historical),
  KeywordData('Theater', Keyword.theater),
  KeywordData('Bookstore', Keyword.bookstore),
  KeywordData('Exposition', Keyword.exposition),
];

final foods = <KeywordData>[
  KeywordData('Brazilian', Keyword.brazilian),
  KeywordData('Fast Food', Keyword.fastFood),
  KeywordData('Pizza', Keyword.pizza),
  KeywordData('Burger', Keyword.burger),
  KeywordData('Hot Dog', Keyword.hotDog),
  KeywordData('Candy', Keyword.candy),
  KeywordData('Donuts', Keyword.donuts),
  KeywordData('Japanese', Keyword.japanese),
  KeywordData('Mexican', Keyword.mexican),
  KeywordData('Chinese', Keyword.chinese),
  KeywordData('Italian', Keyword.italian),
  KeywordData('Thai', Keyword.thai),
  KeywordData('Greek', Keyword.greek),
  KeywordData('Arabian', Keyword.arabian),
  KeywordData('Coxinha', Keyword.coxinha),
  KeywordData('Marmita', Keyword.marmita),
  KeywordData('Pastel', Keyword.pastel),
  KeywordData('Esfiha', Keyword.esfiha),
];

final musics = <KeywordData>[
  KeywordData('Rock', Keyword.rock),
  KeywordData('Pop', Keyword.pop),
  KeywordData('Country', Keyword.country),
  KeywordData('Eletronic', Keyword.electronic),
  KeywordData('Funk', Keyword.funk),
  KeywordData('House', Keyword.house),
  KeywordData('Trap', Keyword.trap),
  KeywordData('Techno', Keyword.techno),
  KeywordData('Rap', Keyword.rap),
  KeywordData('Samba', Keyword.samba),
  KeywordData('Metal', Keyword.metal),
  KeywordData('Pagode', Keyword.pagode),
  KeywordData('Gospel', Keyword.gospel),
  KeywordData('Classic', Keyword.classic),
  KeywordData('MPB', Keyword.mpb),
  KeywordData('Blues', Keyword.blues),
  KeywordData('Jazz', Keyword.jazz),
  KeywordData('Trance', Keyword.trance),
  KeywordData('Hardcore', Keyword.hardcore),
  KeywordData('Punk', Keyword.punk),
];

final miscellaneous = <KeywordData>[
  KeywordData('LGBT', Keyword.lgbt),
  KeywordData('Gym', Keyword.gym),
  KeywordData('Beer', Keyword.beer),
  KeywordData('Sports', Keyword.sports),
  KeywordData('Games', Keyword.games),
  KeywordData('Dance', Keyword.dance),
  KeywordData('Anime', Keyword.anime),
  KeywordData('Chocolate', Keyword.chocolate),
  KeywordData('Street Art', Keyword.streetArt),
  KeywordData('Bike', Keyword.bike),
  KeywordData('Skate', Keyword.skate),
  KeywordData('Rollerblades', Keyword.rollerblades),
  KeywordData('Art', Keyword.art),
  KeywordData('Tattoo', Keyword.tattoo),
  KeywordData('Meditation', Keyword.meditation),
  KeywordData('Soccer', Keyword.soccer),
  KeywordData('Basketball', Keyword.basketball),
  KeywordData('Volleyball', Keyword.volleyball),
  KeywordData('Tennis', Keyword.tennis),
  KeywordData('UFC', Keyword.ufc),
  KeywordData('Boxing', Keyword.boxing),
  KeywordData('Brazilian Jiu Jitsu', Keyword.bjj),
  KeywordData('Thai Boxing', Keyword.thaiBoxing),
  KeywordData('Gin', Keyword.gin),
  KeywordData('Drinks', Keyword.drinks),
];
