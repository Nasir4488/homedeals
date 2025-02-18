import 'package:get/get.dart';

class DeviceWidths {
  static const double tabletWidthMin = 768.0;
  static const double tabletWidthMax = 1024.0;

  static const double desktopWidthMin = 1024.0;
  static const double desktopWidthMax = 1920.0;
}

// var screenHeight=Get.height;
// var screenWidth=Get.width;

var images = [
  "assets/images/home_bg.jpg",
  "assets/images/home_bg.jpg",
  "assets/images/home_main.jpg",
  "assets/images/home_main.jpg",
  "assets/images/home_main.jpg",
  "assets/images/home_main.jpg",
];
final List<String> socialMediaUrls = [
  'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Facebook_colored_svg_copy-512.png',
  'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Twitter3_colored_svg-512.png',
  'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Linkedin_unofficial_colored_svg-512.png',
  'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Instagram_colored_svg_1-512.png',
  'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Youtube_colored_svg-512.png',
  'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Whatsapp2_colored_svg-512.png',
];

//property type

List<String> propertyTypes = [
  "Default Type",
  'Commercial',
  'Residential',
  'Industrial',
  'Land',
  "Developers projects"
];

List<String> residential = [
  'Apartment',
  'House',
  'Building'
];

List<String> sorts = [
  "Default Sort",
  "Price Low to High",
  "Price High to Low",
  "Newest Listings",
  "Oldest Listings"
];
Map<String, String> sortMapping = {
  "Default Sort": "-listingDate", // or default to '-listingDate' in backend
  "Price Low to High": "price",
  "Price High to Low": "-price",
  "Newest Listings": "-listingDate",
  "Oldest Listings": "listingDate",
};
//property status

List<String> propertyStatus = [
  "Default Status",
  "For Sale",
  "For Rent",
  'Auction',
  "Developer Option",
  "Under Construction",
  "Vacant",
  "Pending",

];
// label
List<String> label = [
  "Default Label",
  "Hot Offer",
  "Open House",
  "Sold"
];

List<String> allLabels=[
  "Office",
  "Building",
  "Hotel",
  "Hostel",
  "Coffee Shop",
  "Restaurant",
  "Shop",
  "Parking",
  "Educational Facility",
  "Health Facilty",
  "Data Center",
  "Commercial other",
  "Apartment",
  "House",
  "Building",
  "Warehouse",
  "Factory",
  "Form",
  "WorkShop",
  "Loading Bay",
  "Storage facility",
  "Industrial other",
  "Residential",
  "Commercial",
  "Industrial estate",
  "Agricultural",
  "Forest",
  "Garden",
  "Land other",
  "Apartment",
  "House",
  "Comerical",
  "Land",
];

List<String> comercial=[
  "Office",
  "Building",
  "Hotel",
  "Hostel",
  "Coffee Shop",
  "Restaurant",
  "Shop",
  "Parking",
  "Educational Facility",
  "Health Facilty",
  "Data Center",
  "Commercial other",
];
List<String> residenctial=[
  "Apartment",
  "House",
  "Building",
];
List<String> industrial=[
  "Warehouse",
  "Factory",
  "Form",
  "WorkShop",
  "Loading Bay",
  "Storage facility",
  "Industrial other",
];
List<String> land=[
  "Residential",
  "Commercial",
  "Industrial estate",
  "Agricultural",
  "Forest",
  "Garden",
  "Land other",
];
List<String> developersProjects=[
  "Apartment",
  "House",
  "Comerical",
  "Land",
];

List<int> bedrooms = [ 1, 2, 3, 4, 5, 6, 7, 8, 9];
List<int> bathrooms = [ 1, 2, 3, 4, 5, 6, 7, 8, 9];
List<int> prices = [ 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000,10000];
