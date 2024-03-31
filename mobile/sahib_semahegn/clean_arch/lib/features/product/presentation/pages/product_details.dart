import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/presentation/pages/add_update_product.dart';
import 'package:clean_arch/features/product/presentation/pages/product_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/product/blocs.dart';
import 'pages.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final Product product;
  static const routeName = 'productDetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Image.network(
                          product.imgUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('images/placeholder-image.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.category,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text("(${product.rating['rate'].toString()})")
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: textMedium,
                            ),
                            Text(
                              '\$${product.price.toString()}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizeSelector(sizes: [39, 40, 41, 42, 43, 44, 45]),
                      Text(product.description, style: textSmall),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(DeleteProduct(product.productId));

                              BlocProvider.of<ProductBloc>(context)
                                  .add(GetProducts());

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeScreen.routeName, (route) => false);
                            },
                            child: Text(
                              'DELETE',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF3F51F3)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  AddUpdateProductPage.routeName,
                                  arguments: ProductArguments(
                                      edit: true, product: product));
                            },
                            child: Text(
                              'UPDATE',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                mini: true,
                child: const Icon(
                  Icons.chevron_left,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
