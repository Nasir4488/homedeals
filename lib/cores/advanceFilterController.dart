import 'package:get/get.dart';

import '../utils/constanats.dart';

class AdvanceFilter extends GetxController{

  String selectedLabel = label[0];
  String selectedStatus = propertyStatus[0];
  String selectedType = propertyTypes[0];

  RxString country=countriesList[0].obs;
}