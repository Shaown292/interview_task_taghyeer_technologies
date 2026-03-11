import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/data_sources/auth_remote_ds.dart';
import 'features/auth/data/repository/auth_repository_imp.dart';
import 'features/auth/domain/use_case/log_in_use_case.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/log_in_page.dart';
import 'features/product/data/data_sources/product_remote_ds.dart';
import 'features/product/data/repository/product_repository_imp.dart';
import 'features/product/domain/use_case/product_use_case.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool("loggedIn") ?? false;

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SharedPreferences>.value(value: prefs),

        /// DIO
        RepositoryProvider(create: (_) => Dio()),

        /// AUTH
        RepositoryProvider(
          create: (context) => AuthRemoteDatasource(context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(context.read<AuthRemoteDatasource>()),
        ),
        RepositoryProvider(
          create: (context) => LoginUsecase(context.read<AuthRepositoryImpl>()),
        ),

        /// PRODUCT
        RepositoryProvider(
          create: (context) => ProductsRemoteDatasource(context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) => ProductsRepositoryImpl(context.read<ProductsRemoteDatasource>()),
        ),
        RepositoryProvider(
          create: (context) => GetProductsUsecase(context.read<ProductsRepositoryImpl>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              context.read<LoginUsecase>(),
              context.read<SharedPreferences>(),
            ),
          ),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(context.read<GetProductsUsecase>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Interview Task",
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: loggedIn ? const HomePage() : const LoginPage(),
        ),
      ),
    ),
  );
}