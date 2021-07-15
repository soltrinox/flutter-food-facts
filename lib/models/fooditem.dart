import 'package:foodfacts/models/fooddetails.dart';

class FoodItem {
  String name;
  String foodId;
  String imageUrl;
  String _imageBase64 = '';
  bool _hasImage = false;

  bool _hasDetails = false;
  FoodDetails? _foodDetails;

  FoodItem({
    required this.name,
    required this.foodId,
    required this.imageUrl,
  });

  set imageBase64(String imageBytes) {
    _hasImage = true;
    _imageBase64 = imageBytes;
  }

  bool hasDetails() {
    return _hasDetails;
  }

  bool hasImage() {
    return _hasImage;
  }

  set foodDetails(FoodDetails? foodDetails) {
    _foodDetails = foodDetails;
    _hasDetails = true;
  }

  FoodDetails? get foodDetails {
    return _foodDetails;
  }

  get image {
    return _imageBase64;
  }
}
