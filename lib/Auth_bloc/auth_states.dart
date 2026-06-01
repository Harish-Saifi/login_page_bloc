part of 'auth_bloc.dart';

sealed class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthError extends AuthStates {
  String? emailErrorMsg;
  String? passwordErrorMsg;
  AuthError(this.emailErrorMsg,this.passwordErrorMsg);
}

class AuthInvalid extends AuthStates {
  String errorMsg;
  AuthInvalid({required this.errorMsg});
}

class AuthSuccess extends AuthStates {}
