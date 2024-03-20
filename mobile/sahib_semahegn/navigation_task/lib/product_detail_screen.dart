import 'package:ecommerce_ui_task/home_screen.dart';
import 'package:ecommerce_ui_task/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Product product = args['product'];
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
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
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
                                Text('(${product.ratings.toString()})')
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
                              product.productName,
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
                      SizeSelector(sizes: product.avalaibleSizes),
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
                            onPressed: () {},
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
                              Navigator.pushNamed(context, '/edit_product',
                                  arguments: product);
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

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key, required this.sizes});

  final List<int> sizes;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedidx = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: widget.sizes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          int size = widget.sizes[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedidx = index;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 12, bottom: 13, left: 4),
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      selectedidx == index ? Color(0xFF3F51F3) : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '$size',
                  style: TextStyle(
                    color: selectedidx == index ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
