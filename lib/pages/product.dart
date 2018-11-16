import 'dart:async';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import './../scoped_models/connected_models.dart';
import './../models/product.dart';

import './../widgets/products/ui_elements/title_defaut.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;
  // constructor
  ProductPage(this.productIndex);

  // _showWarningDialog(BuildContext context, title) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Delete product - ' + title),
  //         content: Text('Are you sure to delete this product?'),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('Descard'),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //           FlatButton(
  //             child: Text('Continue'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.pop(context, true);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildAddressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Kegalle, Sri Lanka',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Oswald',
          ),
        ),
        Container(
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Text(
          '\$\ ${price.toString()}',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Oswald',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
          final Product product = model.allProducts[productIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(product.image),
                TitleDefault(product.title),
                _buildAddressPriceRow(product.price),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {},
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
