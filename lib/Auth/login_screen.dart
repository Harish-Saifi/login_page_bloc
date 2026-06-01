import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page_bloc/Auth_bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwdController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: .topCenter,
            end: .centerEnd,
            colors: [
          Colors.blueAccent,
          Colors.blue[50]!,
          Colors.blue[100]!,
          Colors.blue[200]!,
          Colors.blue[300]!,
          Colors.blue[400]!,
          Colors.blue[500]!,
          Colors.blueAccent,
        ]),
      ),
      child: BlocListener<AuthBloc,AuthStates>(
        listener: (context,state){
          if(state is AuthInvalid){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMsg)),
            );
          }
          else if(state is AuthSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Success !!!!")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Back ! ",style: TextStyle(
                            fontSize: 40,
                            fontWeight: .w600
                        ),),
                        SizedBox(height: 30,),
                        Text("Enter your email",style: TextStyle(
                            fontSize: 18,
                            fontWeight: .w400,
                            color: Colors.black
                        ),),
                        SizedBox(height: 10,),
                        BlocBuilder<AuthBloc,AuthStates>(
                            builder: (context,state){
                              return TextFormField(
                                decoration: InputDecoration(
                                  errorText: (state is AuthError) ? state.emailErrorMsg : null,
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.black,
                                      )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.yellow,
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.yellow,
                                      )
                                  ),
                                ),
                                controller: emailController,
                              );
                            }),
                        SizedBox(height: 20,),
                        Text("Enter your password",style: TextStyle(
                            fontSize: 18,
                            fontWeight: .w400,
                            color: Colors.black
                        ),),
                        SizedBox(height: 10,),
                        BlocBuilder<AuthBloc,AuthStates>(
                            builder: (context,state){
                              return TextFormField(
                                decoration: InputDecoration(
                                  errorText:  (state is AuthError) ? state.passwordErrorMsg : null,
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.black,
                                      )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.yellow,
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.yellow,
                                      )
                                  ),
                                ),
                                controller: passwdController,
                                obscureText: true,
                              );
                            }),
                      ],
                    ),
                    BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
                      return Visibility(
                        visible: (state is AuthLoading) ? true : false,
                        child: Center(child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CircularProgressIndicator(strokeWidth: 5,color: Colors.black,))),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 50,),
                Center(
                  child: BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
                    return ElevatedButton(
                      onPressed: (state is AuthLoading) ? null : (){
                        context.read<AuthBloc>().add(
                            AuthSubmittedEvent(email: emailController.text.trim(), password: passwdController.text.trim())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      child: Text("Login",style: TextStyle(
                          fontSize: 20,
                          fontWeight: .w500
                      ),),
                    );
                  })
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
