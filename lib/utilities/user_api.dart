// This class will be used to store all the user data, which will be available globally within the app

class UserApi {

  UserApi._privateConstructor();

  static final UserApi _instance = UserApi._privateConstructor();
  static UserApi get instance => _instance;

  int id;
  String email;
  String name;
  int phoneNumber;
  String houseName;
  String streetName;
  String cityName;
  String stateName;
  String postalCode;
  String countryName;
  double latitude;
  double longitude;

  UserApi({this.id, this.email, this.name, this.phoneNumber, this.houseName,
      this.streetName, this.cityName, this.stateName, this.postalCode,
      this.countryName,this.latitude,this.longitude});

}