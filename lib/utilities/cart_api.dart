// This class will be used to store all the dishes in cart

class CartApi {

  CartApi._privateConstructor();

  static final CartApi _instance = CartApi._privateConstructor();
  static CartApi get instance => _instance;

  List<Map> cartItems = [];

  CartApi(this.cartItems);

}