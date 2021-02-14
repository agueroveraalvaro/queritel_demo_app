
class OrderTable {

  String _id;
  String _price;
  String _date;

  OrderTable(this._id, this._price, this._date);

  //GET
  String get id => _id;
  String get price => _price;
  String get date => _date;

  //SET
  set price(String newPrice) {
    if (newPrice.length <= 255) {
      this._price = newPrice;
    }
  }
  set date(String newDate) {
    if (newDate.length <= 255) {
      this._date = newDate;
    }
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if(_id != null)
      map['id'] = _id;
    map['price'] = _price;
    map['date'] = _date;

    return map;
  }

  OrderTable.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'].toString();
    this._price = map['price'];
    this._date = map['date'];
  }
}








