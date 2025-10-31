import 'package:get/get.dart';

class SelectionController extends GetxController {
  final selectedItemName = ''.obs;
  final selectedItemIconName = ''.obs; // use icons from icon_utils
  final enteredPrice = 0.0.obs;
  final selectedInvestmentSymbol = ''.obs;
  final selectedInvestmentName = ''.obs;
  final selectedInvestmentEmoji = ''.obs;

  void pickItemFull(String name, {String? emoji, String? iconName}) {
    selectedItemName.value = name;
    selectedItemIconName.value = iconName ?? '';
  }

  void setPrice(double price) {
    enteredPrice.value = price;
  }

  void pickInvestment(String symbol, String name, String emoji) {
    selectedInvestmentSymbol.value = symbol;
    selectedInvestmentName.value = name;
    selectedInvestmentEmoji.value = emoji;
  }
}
