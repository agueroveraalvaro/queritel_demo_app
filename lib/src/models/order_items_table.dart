
class OrderItemsTable {

  String _id;
  String _orderId;
  String _quantity;
  String _category;
  String _brand;
  String _title;
  String _weight;
  String _weightLabel;
  String _picUrl;
  String _liderPrice;

  OrderItemsTable(this._id, this._orderId, this._quantity, this._category, this._brand, this._title, this._weight, this._weightLabel, this._picUrl, this._liderPrice);

  //GET
  String get id => _id;
  String get orderId => _orderId;
  String get quantity => _quantity;
  String get category => _category;
  String get brand => _brand;
  String get title => _title;
  String get weight => _weight;
  String get weightLabel => _weightLabel;
  String get picUrl => _picUrl;
  String get liderPrice => _liderPrice;

  //SET
  set orderId(String newOrderId) {
    if (newOrderId.length <= 255) {
      this._orderId = newOrderId;
    }
  }
  set quantity(String newQuantity) {
    if (newQuantity.length <= 255) {
      this._quantity = newQuantity;
    }
  }
  set category(String newCategory) {
    if (newCategory.length <= 255) {
      this._category = newCategory;
    }
  }
  set brand(String newBrand) {
    if (newBrand.length <= 255) {
      this._brand = newBrand;
    }
  }
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }
  set weight(String newWeight) {
    if (newWeight.length <= 255) {
      this._title = newWeight;
    }
  }
  set weightLabel(String newWeightLabel) {
    if (newWeightLabel.length <= 255) {
      this._weightLabel = newWeightLabel;
    }
  }
  set picUrl(String newPicUrl) {
    if (newPicUrl.length <= 255) {
      this._picUrl = newPicUrl;
    }
  }
  set liderPrice(String newLiderPrice) {
    if (newLiderPrice.length <= 255) {
      this._liderPrice = newLiderPrice;
    }
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if(_id != null)
      map['id'] = _id;
    map['order_id'] = _orderId;
    map['item_quantity'] = _quantity;
    map['item_category'] = _category;
    map['item_brand'] = _brand;
    map['item_name'] = _title;
    map['weight'] = _weight;
    map['weight_label'] = _weightLabel;
    map['img_url'] = _picUrl;
    map['item_price'] = _liderPrice;

    return map;
  }

  OrderItemsTable.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'].toString();
    this.orderId = map['order_id'].toString();
    this._quantity = map['item_quantity'];
    this._category = map['item_category'];
    this._brand = map['item_brand'];
    this._title = map['item_name'];
    this._weight = map['weight'];
    this._weightLabel = map['weight_label'];
    this._picUrl = map['img_url'];
    this._liderPrice = map['item_price'];
  }
}








