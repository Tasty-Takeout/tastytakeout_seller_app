String formatMoney(int cost) {
  // add "." after every 3 digits
  String costString = cost.toString();
  String result = "";
  int count = 0;
  for (int i = costString.length - 1; i >= 0; i--) {
    count++;
    result = costString[i] + result;
    if (count == 3 && i != 0) {
      result = "." + result;
      count = 0;
    }
  }
  return result + "đ";
}

String formatSeperateMoney(int cost) {
  // add "." after every 3 digits
  if (cost == 0) return "";

  String costString = cost.toString();
  String result = "";
  int count = 0;
  for (int i = costString.length - 1; i >= 0; i--) {
    count++;
    result = costString[i] + result;
    if (count == 3 && i != 0) {
      result = "," + result;
      count = 0;
    }
  }
  return result;
}

int formatRemoveSeperateMoney(String cost) {
  // add "." after every 3 digits
  String costString = cost.replaceAll(",", "");
  return int.parse(costString);
}
