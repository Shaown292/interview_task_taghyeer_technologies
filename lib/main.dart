import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/product/data/data_sources/product_remote_ds.dart';
import 'features/product/data/repository/product_repository_imp.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/domain/use_case/product_use_case.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'home_page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool("loggedIn") ?? false;

  runApp(MyApp(loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp(this.loggedIn, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1️⃣ Provide Dio instance
        Provider<Dio>(
          create: (_) => Dio(),
        ),

        // 2️⃣ Provide the remote datasource, depends on Dio
        ProxyProvider<Dio, ProductsRemoteDatasource>(
          update: (_, dio, __) => ProductsRemoteDatasource(dio),
        ),

        // 3️⃣ Repository depends on remote datasource
        ProxyProvider<ProductsRemoteDatasource, ProductsRepository>(
          update: (_, datasource, __) => ProductsRepositoryImpl(datasource),
        ),

        // 4️⃣ Usecase depends on repository
        ProxyProvider<ProductsRepository, GetProductsUsecase>(
          update: (_, repository, __) => GetProductsUsecase(repository),
        ),

        // 5️⃣ Bloc depends on usecase
        ProxyProvider<GetProductsUsecase, ProductsBloc>(
          update: (_, usecase, __) => ProductsBloc(usecase),
          dispose: (_, bloc) => bloc.close(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );;
  }
}