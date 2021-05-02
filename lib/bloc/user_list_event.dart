import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable{
  const LoginEvent();
}
class ShowList extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

