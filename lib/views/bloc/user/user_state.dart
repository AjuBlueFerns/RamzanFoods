import 'package:crocurry/data/models/user_model.dart';

class UserState {
  final UserModel? user;
  final bool? isUpdating;
  UserState({
    this.user,
    this.isUpdating= false,
  });

  UserState copyWith({UserModel? userModel, bool? updating}) {
    return UserState(
      user: userModel ?? user,
      isUpdating: updating?? isUpdating,
    );
  }
}
