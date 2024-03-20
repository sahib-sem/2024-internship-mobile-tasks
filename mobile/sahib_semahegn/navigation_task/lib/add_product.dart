import 'package:ecommerce_ui_task/home_screen.dart';
import 'package:ecommerce_ui_task/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenArgs {
  Product? product;
}

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key, this.edit = false});

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    String title = edit ? 'Edit product' : 'Add Product';
    String action = edit ? 'Update' : 'Add';
    Product? product = ModalRoute.of(context)!.settings.arguments as Product?;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        title,
                        style: textMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.image,
                                size: 35,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Upload Image', style: textSmall),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildInputLabel('name'),
                      _buildInputField(product?.productName ?? ''),
                      _buildInputLabel('category'),
                      _buildInputField(product?.category ?? ''),
                      _buildInputLabel('price'),
                      _buildInputField(
                        product?.price.toString() ?? "0.0",
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')), // Only allow digits
                        ],
                        suffixIcon: const Icon(Icons.attach_money),
                        keyboardType: TextInputType.number,
                      ),
                      _buildInputLabel('description'),
                      Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 8),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200]),
                          child: TextFormField(
                            initialValue: product?.description ?? "",
                            maxLines: 8,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Column(
                    children: [
                      _buildButton(action, const Color(0xFF3F51F3),
                          Colors.white, const Color(0xFF3F51F3)),
                      if (edit)
                        _buildButton(
                            'DELETE', Colors.white, Colors.red, Colors.red)
                    ],
                  ),
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
            )
          ]),
        ),
      ),
    );
  }
}

Row _buildInputLabel(String label) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        label,
        style: textSmallBold,
        textAlign: TextAlign.left,
      ),
    ],
  );
}

Container _buildInputField(String initValue,
    {List<TextInputFormatter> inputFormatters = const [],
    TextInputType? keyboardType,
    Widget? suffixIcon}) {
  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
    child: TextFormField(
      initialValue: initValue,
      decoration: InputDecoration(
        border: InputBorder.none,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    ),
  );
}

Container _buildButton(
    String label, Color backgroundColor, Color textColor, Color borderColor) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        // Add your button press logic here
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
              color: borderColor, width: 1.0), // Change border color and width
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor), // Change button background color
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16)), // Add padding
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set border radius
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor), // Customize text style
      ),
    ),
  );
}
