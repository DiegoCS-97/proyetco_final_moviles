import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/welcome.dart';
import 'package:proyecto/login_page.dart';
import 'package:proyecto/authentication/authentication_bloc/authentication_bloc.dart';

void main() async {
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(VerifyAuthenticatedUser()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Escaner",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[200],
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticatedSuccessfully) return Welcome();
          if (state is UnAuthenticated) return LoginPage();
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
