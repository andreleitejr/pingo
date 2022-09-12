class Keyword {
  final String title;
  final int id;

  Keyword(this.title, this.id);
}

class KeywordValue {
  /// TYPES OF PLACES
  static const restaurant = 1;
  static const pub = 2;
  static const party = 3;
  static const concert =4;
  static const park = 5;
  static const museum = 6;
  static const square = 7;
  static const cinema = 8;
  static const historical =9;
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
  static const jazz =47;
  static const trance = 48;
  static const hardcore =49;
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
}

final places = <Keyword>[
  Keyword('Restaurant', KeywordValue.restaurant),
  Keyword('Pub', KeywordValue.pub),
  Keyword('Party', KeywordValue.party),
  Keyword('Concert', KeywordValue.concert),
  Keyword('Park', KeywordValue.park),
  Keyword('Museum', KeywordValue.museum),
  Keyword('Square', KeywordValue.square),
  Keyword('Historical', KeywordValue.historical),
  Keyword('Theater', KeywordValue.theater),
  Keyword('Bookstore', KeywordValue.bookstore),
  Keyword('Exposition', KeywordValue.exposition),
];

final foods = <Keyword>[
  Keyword('Brazilian', KeywordValue.brazilian),
  Keyword('Fast Food', KeywordValue.fastFood),
  Keyword('Pizza', KeywordValue.pizza),
  Keyword('Burger', KeywordValue.burger),
  Keyword('Hot Dog', KeywordValue.hotDog),
  Keyword('Candy', KeywordValue.candy),
  Keyword('Donuts', KeywordValue.donuts),
  Keyword('Japanese', KeywordValue.japanese),
  Keyword('Mexican', KeywordValue.mexican),
  Keyword('Chinese', KeywordValue.chinese),
  Keyword('Italian', KeywordValue.italian),
  Keyword('Thai', KeywordValue.thai),
  Keyword('Greek', KeywordValue.greek),
  Keyword('Arabian', KeywordValue.arabian),
  Keyword('Coxinha', KeywordValue.coxinha),
  Keyword('Marmita', KeywordValue.marmita),
  Keyword('Pastel', KeywordValue.pastel),
  Keyword('Esfiha', KeywordValue.esfiha),
];

final musics = <Keyword>[
  Keyword('Rock', KeywordValue.rock),
  Keyword('Pop', KeywordValue.pop),
  Keyword('Country', KeywordValue.country),
  Keyword('Eletronic', KeywordValue.electronic),
  Keyword('Funk', KeywordValue.funk),
  Keyword('House', KeywordValue.house),
  Keyword('Trap', KeywordValue.trap),
  Keyword('Techno', KeywordValue.techno),
  Keyword('Rap', KeywordValue.rap),
  Keyword('Samba', KeywordValue.samba),
  Keyword('Metal', KeywordValue.metal),
  Keyword('Pagode', KeywordValue.pagode),
  Keyword('Gospel', KeywordValue.gospel),
  Keyword('Classic', KeywordValue.classic),
  Keyword('MPB', KeywordValue.mpb),
  Keyword('Blues', KeywordValue.blues),
  Keyword('Jazz', KeywordValue.jazz),
  Keyword('Trance', KeywordValue.trance),
  Keyword('Hardcore', KeywordValue.hardcore),
  Keyword('Punk', KeywordValue.punk),
];

final miscellaneous = <Keyword>[
  Keyword('Gym', KeywordValue.gym),
  Keyword('Beer', KeywordValue.beer),
  Keyword('Sports', KeywordValue.sports),
  Keyword('Games', KeywordValue.games),
  Keyword('Dance', KeywordValue.dance),
  Keyword('Anime', KeywordValue.anime),
  Keyword('Chocolate', KeywordValue.chocolate),
  Keyword('Street Art', KeywordValue.streetArt),
  Keyword('Bike', KeywordValue.bike),
  Keyword('Skate', KeywordValue.skate),
  Keyword('Rollerblades', KeywordValue.rollerblades),
  Keyword('Art', KeywordValue.art),
  Keyword('Tattoo', KeywordValue.tattoo),
  Keyword('Meditation', KeywordValue.meditation),
  Keyword('Soccer', KeywordValue.soccer),
  Keyword('Basketball', KeywordValue.basketball),
  Keyword('Volleyball', KeywordValue.volleyball),
  Keyword('Tennis', KeywordValue.tennis),
  Keyword('UFC', KeywordValue.ufc),
  Keyword('Boxing', KeywordValue.boxing),
  Keyword('Brazilian Jiu Jitsu', KeywordValue.bjj),
  Keyword('Thai Boxing', KeywordValue.thaiBoxing),
];
