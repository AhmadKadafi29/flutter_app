import 'package:flutter/material.dart';
import 'package:flutter_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_app/pages/auth/auth_page.dart';
import 'package:flutter_app/pages/mahasiswa/mahasiswa_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return const MahasiswaPage();
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
