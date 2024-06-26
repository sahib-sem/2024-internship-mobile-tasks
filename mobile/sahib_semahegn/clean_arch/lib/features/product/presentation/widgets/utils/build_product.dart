import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/pages.dart';

GestureDetector buildProductCard(Product product, BuildContext context) {
  return GestureDetector(
    onTap: () => {
      Navigator.of(context)
          .pushNamed(ProductDetail.routeName, arguments: product)
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
            Image.network(
              product.imgUrl,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('images/placeholder-image.jpg'),
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
                      Text("(${product.rating['rate'].toString()})")
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
