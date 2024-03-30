import 'package:clean_arch/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_events.dart';
import 'package:clean_arch/features/product/presentation/pages/product_route.dart';
import 'package:clean_arch/inject_depedancies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'inject_depedancies.dart' as di;

void main() async {
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(GetProducts()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ecommerce app',
        onGenerateRoute: ProductRoute.generateRoute,
      ),
    );
  }
}
