part of 'auth_bloc.dart';

sealed  class AuthEvents {}

class AuthSubmittedEvent extends AuthEvents {
   final String email;
   final String password;

   AuthSubmittedEvent({required this.email, required this.password});
}

class AuthLogoutEvent extends AuthEvents {}