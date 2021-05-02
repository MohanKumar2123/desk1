import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:desk1/bloc/bloc.dart';

import 'user_model.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();
}

class IntialState extends LoginState {
  @override
  List<Object> get props => [];
}

class OnSuccess extends LoginState {
  final List<UserModel> userListData;
  OnSuccess({this.userListData});
  @override
  List<Object> get props => [userListData];
}

class OnFailure extends LoginState {
  final String errorMessage;
  OnFailure({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
