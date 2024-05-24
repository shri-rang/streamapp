class OptionsModel {
  final String? name;
  final String? image;

  OptionsModel({this.image, this.name});
}

List<OptionsModel> optionList = [
  OptionsModel(name: "Get Delivery", image: "assets/delivery.svg"),
  OptionsModel(name: "Redeem as Jewellery", image: "assets/jewellery.svg"),
  OptionsModel(name: "Sell Your Golds", image: "assets/sellyourgold.svg")
];
