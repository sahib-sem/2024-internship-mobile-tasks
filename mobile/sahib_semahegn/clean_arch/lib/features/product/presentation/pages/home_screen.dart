import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/blocs.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_events.dart';
import 'package:clean_arch/features/product/presentation/pages/add_update_product.dart';
import 'package:clean_arch/features/product/presentation/pages/product_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'pages.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String today = DateFormat('MMMM d, y').format(DateTime.now());

  final List<Product> products = [];
  RangeValues _priceRange = const RangeValues(20, 80);
  Map<String, dynamic> filter = {};

  void _applyFilter(filter, BuildContext context) {
    context.read<ProductBloc>().add(FilterProductsByCategory(
          category: filter['category'] ?? '',
          minPrice: filter['min'] ?? 0,
          maxPrice: filter['max'] ?? 100,
        ));
  }

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

                // add search box and search button

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            context.read<ProductBloc>().add(GetProducts());
                            return;
                          } else {
                            context
                                .read<ProductBloc>()
                                .add(FilterProducts(title: value));
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search product',
                          suffixIcon: const Icon(Icons.arrow_forward_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF3F51F3)),
                      child: IconButton(
                        iconSize: 25,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, StateSetter setState) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // text field for category
                                      TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            filter['category'] = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Category',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      RangeSlider(
                                        values: _priceRange,
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                        labels: RangeLabels(
                                            _priceRange.start
                                                .round()
                                                .toString(),
                                            _priceRange.end.round().toString()),
                                        onChanged: (RangeValues value) {
                                          setState(() {
                                            _priceRange = value;
                                            filter['min'] = value.start;
                                            filter['max'] = value.end;
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 20),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color(0xFF3F51F3)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            _applyFilter(filter, context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'APPLY',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              });
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
                    ))

                    // search button
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // select one for category and Text field for min and max values

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
