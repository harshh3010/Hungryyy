# Hungryyy-Flutter

A food delivery app for android and ios created using flutter.

## Tech Stack

<img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/flutter-logo.png" width="250px">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/dart-logo.png" width="250px">
This app is created using flutter (dart). The UI and main functioning of the app is achieved through dart. This app uses MySQL database for storing the necessary data. The server provider is Apache deployed with PHP scripts for handling specific tasks.
<br>
<br>
<img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/mysql-logo.png" width="250px">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/php-logo.png" width="250px">
<br>
For this application, I created a localhost server using Xampp.
<br>
<br>
<img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/xampp-logo.png" width="80px">
Tasks like email and mobile number verification are achieved using php. Xampp allows us to send mails to newly registered users from localhost through its SMTP server. All you need to do is just make some changes in php.ini and sendmail.ini file.
Speaking of phone verification, I achieved it by sending an OTP to the registered users using TextLocal's SMS services.
<br>
<img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/textlocal-logo.png" width="150px"><img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/nodejs-logo.png" width="150px"><img src="https://github.com/harshh3010/Hungryyy/blob/master/TechStack/paytm-logo.png" width="150px">
This project also uses Node.js for creating a gateway to allow the users to make payments using PayTM. 

## Flutter Packages used
1. **http**: To make http requests to the server
2. **rflutter_alert**: To show custom alert dialog boxes
3. **modal_progress_hud**: To display progress indicators while data is being fetched
4. **geolocator & geocoder**: To get user's location and convert the latitude and longitude obtained to address placemark
5. **image_picker**: To pick up an image from the gallery
6. **intl**: For formatting the DateTime values chosen while booking a product
7. **google_maps_flutter**: To allow the users to track their order on a map
8. **flutter_polyline_points**: To draw routes between source and destination points on a map (Works only when billing is enabled)
9. **flutter_webview_plugin**: To display a webview in our app.(Used in paytm payment screen)
10. **url_launcher**: To launch the default dialer and mailing app on user's device

## App Mock-ups
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/SplashScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/LoginScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/RegistrationScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/PhoneVerification.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/NavigationScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/HomeScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/DishScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/FilterSheet.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/FilteredDishes.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/SearchFilter.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/AllRestaurantsScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/RestaurantScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/CartScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/BillingScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/PayTMScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/OrdersScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/MapScreen.png">
<img src="https://github.com/harshh3010/Hungryyy/blob/master/AppScreenshots/AddressScreen.png">
