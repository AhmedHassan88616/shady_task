class ClinicModel {
  ClinicModel({
    int? id,
    int? userId,
    String? name,
    String? address,
    String? phone,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _address = address;
    _phone = phone;
  }

  ClinicModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _address = json['address'];
    _phone = json['phone'];
  }

  int? _id;
  int? _userId;
  String? _name;
  String? _address;
  String? _phone;

  int? get id => _id;

  int? get userId => _userId;

  String? get name => _name;

  String? get address => _address;

  String? get phone => _phone;

  set id(value) => _id = value;

  set userId(value) => _userId = value;

  set name(value) => _name = value;

  set address(value) => _address = value;

  set phone(value) => _phone = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['address'] = _address;
    map['phone'] = _phone;
    return map;
  }
}
