import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page_bloc/Auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetail = context.watch<AuthBloc>().state;
    return BlocConsumer<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Logout Successful.",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state is AuthException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Exception occurred : ${state.msg}",
                style: TextStyle(color: Colors.orange),
              ),
              backgroundColor: Colors.blueGrey,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text("Welcome to user")),
          body: (state is AuthLoading)
              ? Center(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.black,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    userDetail is AuthResult ? userDetail.email! : "",
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 20, fontWeight: .w500),
              ),
            ),
          ),
        );
      },
    );
  }
}
