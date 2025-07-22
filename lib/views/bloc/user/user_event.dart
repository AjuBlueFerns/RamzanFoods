import 'package:crocurry/data/models/user_model.dart';

abstract class UserEvent {}

class FetchUserDetailsFromShared extends UserEvent {}

class UpdateDetails extends UserEvent {
  final UserModel user;
  UpdateDetails(this.user);
}

class UpdateStatus extends UserEvent {
  final bool status;
  UpdateStatus(this.status);
}

class ClearUserDetailsEvent extends UserEvent {
  ClearUserDetailsEvent();
}
