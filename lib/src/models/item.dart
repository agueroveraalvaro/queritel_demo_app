
class Item {

  String _refId;
  String _category;
  String _brand;
  String _title;
  String _weight;
  String _weightLabel;
  String _picUrl;
  String _liderPrice;
  String _newFileName;

  Item(this._refId, this._category, this._brand, this._title, this._weight, this._weightLabel, this._picUrl, this._liderPrice, this._newFileName);

  //GET
  String get refId => _refId;

  String get category => _category;

  String get brand => _brand;

  String get title => _title;

  String get weight => _weight;

  String get weightLabel => _weightLabel;

  String get picUrl => _picUrl;

  String get liderPrice => _liderPrice;

  String get newFileName => _newFileName;

  //SET
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
  set newFileName(String newNewFileName) {
    if (newNewFileName.length <= 255) {
      this._newFileName = newNewFileName;
    }
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    map['ref_id'] = _refId;
    map['category'] = _category;
    map['brand'] = _brand;
    map['title'] = _title;
    map['weight'] = _weight;
    map['weight_label'] = _weightLabel;
    map['pic_url'] = _picUrl;
    map['lider_price'] = _liderPrice;
    map['new_file_name'] = _newFileName;

    return map;
  }

  Item.fromMapObject(Map<String, dynamic> map) {
    this._refId = map['ref_id'];
    this._category = map['category'];
    this._brand = map['brand'];
    this._title = map['title'];
    this._weight = map['weight'];
    this._weightLabel = map['weight_label'];
    this._picUrl = map['pic_url'];
    this._liderPrice = map['lider_price'];
    this._newFileName = map['new_file_name'];
  }
}








