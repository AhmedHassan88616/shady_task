import 'package:shady_task/data_layer/models/clinic_model.dart';

import '../../shared/network/local/sqlflite_helper.dart';
import '../models/user_model.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  Future userRegister(
      {required UserModel user, required List<ClinicModel> clinics}) async {
    await SQFLiteHelper.saveUser(user);
    final int userId = await getUserId();
    for (int i = 0; i < clinics.length; i++) {
      clinics[i].userId = userId;
      clinics[i].userId = await SQFLiteHelper.saveClinic(clinics[i]);
    }
  }

  Future<UserModel> getUser() async {
    UserModel user = (await SQFLiteHelper.getUsers()).last;
    user.clinics = await SQFLiteHelper.getUserClinics(userId: user.id ?? 0);
    return user;
  }

  Future<int> getUserId() async {
    UserModel user = (await SQFLiteHelper.getUsers()).last;
    return user.id ?? 0;
  }
}
