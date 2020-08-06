class Dish{

  String id;
  String restaurantId;
  String name;
  String categoryId;
  double rating;
  double price;
  double discount;
  String extraName;
  String extraPrice;
  String imageUrl;
  String cityName;
  String stateName;
  String countryName;
  String categoryName;

  Dish({this.id, this.restaurantId, this.name, this.categoryId, this.rating,
      this.price, this.discount, this.extraName, this.extraPrice, this.imageUrl,
      this.cityName, this.stateName, this.countryName, this.categoryName});

  Map<String,Object> toJson(){
    return {
      'id' : id,
      'restaurant_id' : restaurantId,
      'name' : name,
      'category_id' : categoryId,
      'rating' : rating,
      'price' : price,
      'discount' : discount,
      'extra_name' : extraName,
      'extra_price': extraPrice,
      'image_url' : imageUrl,
      'city_name' : cityName,
      'state_name' : stateName,
      'country_name' : countryName,
      'category_name' : categoryName,
    };
  }


}