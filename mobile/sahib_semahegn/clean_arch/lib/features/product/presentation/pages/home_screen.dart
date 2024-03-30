import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/blocs.dart';
import 'package:clean_arch/features/product/presentation/pages/add_update_product.dart';
import 'package:clean_arch/features/product/presentation/pages/product_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'pages.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  HomeScreen({super.key});

  final String today = DateFormat('MMMM d, y').format(DateTime.now());

  final List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            width: 50,
                            height: 50,
                            'images/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              today,
                              style: textSmall,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Hello, ',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sahib',
                                    style: textMedium,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      width: 30,
                      height: 30,
                      child: const Icon(
                        Icons.notifications_on,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Available Products',
                  style: textLarge,
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is AllProductLoaded) {
                      return Column(
                        children: [
                          for (var product in state.products)
                            buildProductCard(product, context),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    } else if (state is ProductError) {
                      return Text(state.message);
                    }

                    return const Text('something went wrong');
                  },
                )
              ],
            )),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).pushNamed(AddUpdateProductPage.routeName,
              arguments: ProductArguments(edit: false))
        },
        backgroundColor: const Color(0xFF3F51F3),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
