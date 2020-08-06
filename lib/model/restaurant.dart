class Restaurant {
  String id;
  String name;
  String streetName;
  String cityName;
  String stateName;
  String postalCode;
  String countryName;
  String phoneNumber;
  double latitude;
  double longitude;
  double rating;
  double deliveryCharge;
  String imageUrl;

  Restaurant({this.id, this.name, this.streetName, this.cityName, this.stateName,
      this.postalCode, this.countryName, this.phoneNumber, this.latitude,
      this.longitude, this.rating, this.deliveryCharge, this.imageUrl});

  Map<String,Object> toJson(){
    return {
      'id' : id,
      'name' : name,
      'street_name' : streetName,
      'city_name' : cityName,
      'state_name' : stateName,
      'postal_code' : postalCode,
      'country_name' : countryName,
      'phone_number' : phoneNumber,
      'latitude' : latitude,
      'longitude' : longitude,
      'rating' : rating,
      'image_url' : imageUrl,
      'delivery_charge' : deliveryCharge,
    };
  }
}