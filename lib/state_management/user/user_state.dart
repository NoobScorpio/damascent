import 'package:damascent/data_management/models/my_user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  UserInitialState();
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final MyUser user;

  UserLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
