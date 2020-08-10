class Order{
  String restaurantId;
  String restaurantName;
  String customerEmail;
  String customerContact;
  String customerName;
  double fromLat,toLat,fromLong,toLong;
  double price;
  String timestamp;
  List cartItems;

  Order({this.restaurantId, this.restaurantName, this.customerEmail, this.customerContact,
      this.customerName, this.fromLat, this.toLat, this.fromLong, this.toLong,
      this.price, this.timestamp,this.cartItems});


}