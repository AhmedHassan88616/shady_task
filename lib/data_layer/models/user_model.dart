import 'package:shady_task/data_layer/models/clinic_model.dart';

class UserModel {
  UserModel({
    int? id,
    String? fullName,
    String? idType,
    String? gender,
    String? birthDate,
    String? personalAddress,
    String? city,
    String? region,
    String? mobile,
    String? email,
    String? password,
    List<ClinicModel>? clinics,
    String? licenseImage,
    String? mainSpeciality,
    String? scientificDegree,
    String? userVideo,
    String? userAudio,
  }) {
    _id = id;
    _fullName = fullName;
    _idType = idType;
    _gender = gender;
    _birthDate = birthDate;
    _personalAddress = personalAddress;
    _city = city;
    _region = region;
    _mobile = mobile;
    _email = email;
    _password = password;
    _clinics = clinics;
    _licenseImage = licenseImage;
    _mainSpeciality = mainSpeciality;
    _scientificDegree = scientificDegree;
    _userVideo = userVideo;
    _userAudio = userVideo;
  }

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _idType = json['id_type'];
    _gender = json['gender'];
    _birthDate = json['birth_date'];
    _personalAddress = json['personal_address'];
    _city = json['city'];
    _region = json['region'];
    _mobile = json['mobile'];
    _email = json['email'];
    _password = json['password'];
    _licenseImage = json['license_image'];
    _mainSpeciality = json['main_speciality'];
    _scientificDegree = json['scientific_degree'];
    _userVideo = json['user_video'];
    _userAudio = json['user_audio'];
  }

  int? _id;
  String? _fullName;
  String? _idType;
  String? _gender;
  String? _birthDate;
  String? _personalAddress;
  String? _city;
  String? _region;
  String? _mobile;
  String? _email;
  String? _password;
  List<ClinicModel>? _clinics;
  String? _mainSpeciality;
  String? _scientificDegree;
  String? _licenseImage;
  String? _userVideo;
  String? _userAudio;

  int? get id => _id;

  String? get fullName => _fullName;

  String? get idType => _idType;

  String? get gender => _gender;

  String? get birthDate => _birthDate;

  String? get personalAddress => _personalAddress;

  String? get city => _city;

  String? get region => _region;

  String? get mobile => _mobile;

  String? get email => _email;

  String? get password => _password;

  String? get mainSpeciality => _mainSpeciality;

  String? get scientificDegree => _scientificDegree;

  List<ClinicModel>? get clinics => _clinics;

  String? get licenseImage => _licenseImage;
  String? get userVideo => _userVideo;
  String? get userAudio => _userAudio;

  set id(value) => _id = value;

  set fullName(value) => _fullName = value;

  set idType(value) => _idType = value;

  set gender(value) => _gender = value;

  set birthDate(value) => _birthDate = value;

  set personalAddress(value) => _personalAddress = value;

  set city(value) => _city = value;

  set region(value) => _region = value;

  set mobile(value) => _mobile = value;

  set email(value) => _email = value;

  set password(value) => _password = value;

  set mainSpeciality(value) => _mainSpeciality = value;

  set scientificDegree(value) => _scientificDegree = value;

  set clinics(value) => _clinics = value;

  set licenseImage(value) => _licenseImage = value;
  set userVideo(value) => _userVideo = value;
  set userAudio(value) => _userAudio = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = _fullName;
    map['id_type'] = _idType;
    map['gender'] = _gender;
    map['birth_date'] = _birthDate;
    map['personal_address'] = _personalAddress;
    map['city'] = _city;
    map['region'] = _region;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['password'] = _password;
    map['license_image'] = _licenseImage;
    map['main_speciality'] = _mainSpeciality;
    map['scientific_degree'] = _scientificDegree;
    map['user_video'] = _userVideo;
    map['user_audio'] = _userAudio;
    return map;
  }
}
