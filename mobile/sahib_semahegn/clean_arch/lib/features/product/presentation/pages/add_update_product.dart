import 'dart:io';

import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_events.dart';
import 'package:clean_arch/features/product/presentation/pages/pages.dart';
import 'package:clean_arch/features/product/presentation/pages/product_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateProductPage extends StatefulWidget {
  const AddUpdateProductPage({super.key, required this.args});

  final ProductArguments args;
  static const routeName = 'addUpdateProduct';

  @override
  State<AddUpdateProductPage> createState() => _AddUpdateProductPageState();
}

class _AddUpdateProductPageState extends State<AddUpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _product = {};

  File? _imageFile = File('images/placeholder-image.jpg');

  void _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Container _buildInputField(String name, String initValue,
      {List<TextInputFormatter> inputFormatters = const [],
      TextInputType? keyboardType,
      Widget? suffixIcon}) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
      child: TextFormField(
        initialValue: initValue,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            _product[name] = value;
          });
        },
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

  Container _buildButton(String label, Color backgroundColor, Color textColor,
      Color borderColor, BuildContext context, ProductArguments args) {
    debugPrint(_product.toString());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (args.edit && label == 'DELETE') {
            BlocProvider.of<ProductBloc>(context)
                .add(DeleteProduct(args.product!.productId));
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          } else if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if (widget.args.product != null) {
              ProductModel product = ProductModel(
                name: _product['name'],
                description: _product['description'],
                price: double.parse(_product['price']),
                imgUrl: widget.args.product!.imgUrl,
                category: _product['category'],
                rating: widget.args.product!.rating,
                productId: widget.args.product!.productId,
              );

              BlocProvider.of<ProductBloc>(context).add(UpdateProduct(product));
            } else {
              ProductModel product = ProductModel(
                name: _product['name'],
                description: _product['description'],
                price: double.parse(_product['price']),
                imgUrl: '',
                category: _product['category'],
                rating: const {"rate": 0, "count": 0},
                productId: '',
              );

              BlocProvider.of<ProductBloc>(context)
                  .add(CreateProduct(product, image: _imageFile));
            }
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          }
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
                color: borderColor,
                width: 1.0), // Change border color and width
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          widget.args.edit ? 'Edit Product' : 'Add Product',
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
                            child: GestureDetector(
                              onTap: _selectImage,
                              child: _imageFile == null
                                  ? Column(
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
                                    )
                                  : Image.file(
                                      _imageFile!,
                                      height: 200,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildInputLabel('name'),
                        _buildInputField(
                            'name', widget.args.product?.name ?? ''),
                        _buildInputLabel('category'),
                        _buildInputField(
                            'category', widget.args.product?.category ?? ''),
                        _buildInputLabel('price'),
                        _buildInputField(
                          'price',
                          widget.args.product?.price.toString() ?? '',
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              initialValue:
                                  widget.args.product?.description ?? '',
                              maxLines: 8,
                              onSaved: (value) {
                                setState(() {
                                  _product['description'] = value;
                                });
                              },
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Column(
                    children: [
                      _buildButton(
                          widget.args.edit ? 'UPDATE' : 'ADD',
                          const Color(0xFF3F51F3),
                          Colors.white,
                          const Color(0xFF3F51F3),
                          context,
                          ProductArguments(
                            edit: true,
                            product: widget.args.product,
                          )),
                      if (widget.args.edit)
                        _buildButton('DELETE', Colors.white, Colors.red,
                            Colors.red, context, ProductArguments(edit: true))
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
