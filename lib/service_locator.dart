import 'package:get_it/get_it.dart';

import 'models/user_account_model.dart';

final getIt = GetIt.instance;
//this will help to call any method or peoperty in the project and access app models
void setupLocator() {
  getIt.registerSingleton<UserAccountModel>(UserAccountModel());
}
