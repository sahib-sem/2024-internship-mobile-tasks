import 'package:ecommerce_ui_task/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final TextStyle textLarge = GoogleFonts.poppins(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);
final TextStyle textMedium = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
final TextStyle textSmall = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.grey,
);
final TextStyle textSmallBold = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);
final Product product = Product(
    imageUrl: 'images/product.jpg',
    category: "Men's shoe",
    productName: 'Derby Leather Shoes',
    ratings: 4.0,
    description:
        'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions.ith their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
    price: 120,
    avalaibleSizes: [39, 40, 41, 42, 43, 44]);

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final String today = DateFormat('MMMM d, y').format(DateTime.now());

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
                Column(
                  children: [
                    _buildProductCard(product, context),
                    _buildProductCard(product, context),
                    _buildProductCard(product, context),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                )
              ],
            )),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, '/add_product')},
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

GestureDetector _buildProductCard(Product product, BuildContext context) {
  return GestureDetector(
    onTap: () => {
      Navigator.pushNamed(context, '/product_detail',
          arguments: {'product': product})
    },
    child: Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Column(
          children: [
            Image.asset(
              product.imageUrl,
            ),
            const SizedBox(
              height: 14.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
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
            )
          ],
        ),
      ),
    ),
  );
}
