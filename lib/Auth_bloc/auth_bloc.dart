import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_states.dart';
part 'auth_events.dart';

class AuthBloc  extends Bloc<AuthEvents,AuthStates>{
    AuthBloc():super(AuthInitial()) {
      on<AuthSubmittedEvent>((event,state)async{
           String email = event.email;
           String password = event.password;
           var (emailError, passwordError) = validateInput(email, password);
           if(emailError != null || passwordError != null){
               return emit(AuthError(emailError, passwordError));
           }
           emit(AuthLoading());
           await Future.delayed(Duration(seconds: 3));
           String msg = checkInput(email, password);
           return emit(AuthResult(msg: msg,email: email));
      });
      on<AuthLogoutEvent>((event,state){
        emit(AuthLogout());
      });
    }


    (String?, String?) validateInput(String email,String password){

      String? emailErr = null;
      String? psswdErr = null;
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


    String checkInput(String email, String password){
         if(email == "abc@yopmail.com" && password == "123abc"){
            return "Login Successful";
         }
         return "Invalid Credentials";
    }



}