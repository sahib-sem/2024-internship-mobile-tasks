import 'dart:convert';

import 'package:clean_arch/features/product/data/models/product_model.dart';

import '../fixture/fixture.dart';

ProductModel testProductModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));
