class FoodDetails {
  double healthScore = -1;
  bool vegetarian;
  bool vegan;
  bool glutenFree;
  bool dairyFree;
  bool veryHealthy;
  bool cheap;
  bool veryPopular;
  bool sustainable;

  FoodDetails(
      {required this.healthScore,
      required this.vegetarian,
      required this.vegan,
      required this.glutenFree,
      required this.dairyFree,
      required this.cheap,
      required this.veryHealthy,
      required this.sustainable,
      required this.veryPopular});
}
