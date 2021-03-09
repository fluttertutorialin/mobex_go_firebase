class AscListResponse {
  String vendCode;
  String name;
  String address1;
  String city;
  String postalCode;
  bool isSelected = false;

  AscListResponse({this.isSelected, this.vendCode, this.name, this.address1, this.city, this.postalCode});

  AscListResponse.fromJson(Map<String, dynamic> json) {
    vendCode = json['VENDCODE'];
    name = json['NAME1'];
    address1 = json['ADDR1'];
    city = json['CITY'];
    postalCode = json['POSTALCODE'];
  }
}
