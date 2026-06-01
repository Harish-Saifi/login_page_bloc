import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page_bloc/Auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
           return (state is AuthResult) ? Text(state.email ?? "Hello") : Text("Hello");
        })
      ),
    );
  }
}
