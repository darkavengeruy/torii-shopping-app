import 'package:flutter/material.dart';
import 'package:toriishopping/src/common/di/depdendencies_provider.dart';
import 'package:toriishopping/src/common/presentation/blocs/BlocProvider.dart';
import 'package:toriishopping/src/products/domain/entities/product.dart';
import 'package:toriishopping/src/products/presentation/blocs/product_bloc.dart';
import 'package:toriishopping/src/products/presentation/screens/product_screen.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  ProductItemWidget({Key key, @required this.product});

  @override
  Widget build(BuildContext context) {
    final size =  125.0;

    return new GestureDetector(
        onTap: () {
          final screen = ProductScreen.createWidget(product);

          Navigator.push(
            context,
            MaterialPageRoute(
                //builder: (context) => BrowserScreen(url: product.url),
                builder: (context) => screen),
          );
        },
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Hero(
                  tag: product.asin,
                  child: product.images.length > 0
                      ? Image.network(
                          product.images[0],
                          fit: BoxFit.contain,
                          height: size,
                          width: size,
                        )
                      : Image.asset(
                          'assets/images/empty_image.png',
                          height: size,
                          width: size,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(product.name,
                        style: Theme.of(context).textTheme.title),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
