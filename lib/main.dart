import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page_bloc/Auth/login_screen.dart';
import 'package:login_page_bloc/Auth_bloc/auth_bloc.dart';
import 'package:login_page_bloc/bloc_observer.dart';

void main() {
  Bloc.observer = Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.pink),
        ),
        home: LoginScreen(),
      ),
    );
  }
}

