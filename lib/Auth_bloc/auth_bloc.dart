import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_states.dart';
part 'auth_events.dart';

class AuthBloc  extends Bloc<AuthEvents,AuthStates>{
    AuthBloc():super(AuthInitial()) {
      on<AuthSubmittedEvent>(_onAuthSubmittedEvent);
      on<AuthLogoutEvent>(_onAuthLogoutEvent);
    }


  //   @override
  //   void onChange(Change<AuthStates> change) {
  //     super.onChange(change);
  //     debugPrint("Change of state : $change");
  //   }
  //
  //   @override
  // void onTransition(Transition<AuthEvents, AuthStates> transition) {
  //   super.onTransition(transition);
  //   debugPrint("Transition : $transition");
  // }

    Future<void> _onAuthSubmittedEvent(AuthSubmittedEvent event,Emitter<AuthStates> emit) async{
      String email = event.email;
      String password = event.password;
      var (emailError, passwordError) = _validateInput(email, password);
      if(emailError != null || passwordError != null){
        return emit(AuthError(emailError, passwordError));
      }
      emit(AuthLoading());
      await Future.delayed(Duration(seconds: 3));
      String msg = _checkInput(email, password);
      return emit(AuthResult(msg: msg,email: email));
    }

    (String?, String?) _validateInput(String email,String password){

      String? emailErr;
      String? psswdErr;
      if(email.isEmpty){
           emailErr = "*Email is required.";
      }
      else if(!email.contains("@")){
           emailErr = "*Invalid email.";
      }
      if(password.isEmpty){
         psswdErr = "*Password is required.";
      }
      else if(password.length < 6){
         psswdErr = "*Password should be atleast 6 characters long";
      }
      return (emailErr,psswdErr);
    }

    String _checkInput(String email, String password){
         if(email == "abc@yopmail.com" && password == "123abc"){
            return "Login Successful";
         }
         return "Invalid Credentials";
    }

    Future<void> _onAuthLogoutEvent (AuthLogoutEvent event, Emitter<AuthStates> emit) async{
      emit(AuthLoading());
      try{
        await Future.delayed(Duration(seconds: 2));
        emit(AuthInitial());
      }catch(e){
        emit(AuthException(e.toString()));
      }
    }


}