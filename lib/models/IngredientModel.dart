class Ingredient {
  final int id;
  final String name;

  final bool isVegan;
  final bool isVegetarian;
  final bool isHalal;
  final bool isKosher;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isNutFree;
  final bool isSoyFree;
  final bool isEggFree;
  final bool isShellfishFree;
  final bool isPeanutFree;
  final bool isWheatFree;
  final bool isFishFree;
  final bool isDairyFree;
  final bool isSesameFree;
  final bool isCeleryFree;
  final bool isMustardFree;
  final bool isLupinFree;
  final bool isMolluscFree;
  final bool isAlcoholFree;
  final bool isCaffeineFree;
  final bool isSugarFree;

  Ingredient({
    required this.id,
    required this.name,

    this.isVegan = false,
    this.isVegetarian = false,
    this.isHalal = false,
    this.isKosher = false,
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.isNutFree = false,
    this.isSoyFree = false,
    this.isEggFree = false,
    this.isShellfishFree = false,
    this.isPeanutFree = false,
    this.isWheatFree = false,
    this.isFishFree = false,
    this.isDairyFree = false,
    this.isSesameFree = false,
    this.isCeleryFree = false,
    this.isMustardFree = false,
    this.isLupinFree = false,
    this.isMolluscFree = false,
    this.isAlcoholFree = false,
    this.isCaffeineFree = false,
    this.isSugarFree = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,

      'isVegan': isVegan,
      'isVegetarian': isVegetarian,
      'isHalal': isHalal,
      'isKosher': isKosher,
      'isGlutenFree': isGlutenFree,
      'isLactoseFree': isLactoseFree,
      'isNutFree': isNutFree,
      'isSoyFree': isSoyFree,
      'isEggFree': isEggFree,
      'isShellfishFree': isShellfishFree,
      'isPeanutFree': isPeanutFree,
      'isWheatFree': isWheatFree,
      'isFishFree': isFishFree,
      'isDairyFree': isDairyFree,
      'isSesameFree': isSesameFree,
      'isCeleryFree': isCeleryFree,
      'isMustardFree': isMustardFree,
      'isLupinFree': isLupinFree,
      'isMolluscFree': isMolluscFree,
      'isAlcoholFree': isAlcoholFree,
      'isCaffeineFree': isCaffeineFree,
      'isSugarFree': isSugarFree,
    };
  }
}
