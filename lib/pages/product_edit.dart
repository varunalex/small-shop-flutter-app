import 'package:flutter/material.dart';

import './../models/product.dart';

import './../validation/validation.dart';

class EditProductPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;
  EditProductPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});
  @override
  State<StatefulWidget> createState() {
    return _EditProductPageState();
  }
}

class _EditProductPageState extends State<EditProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  bool _isSubmited = false;

  Widget _buildTitleTextField() {
    String label = 'Product title';
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product.title,
      decoration: InputDecoration(labelText: label),
      validator: (String value) {
        return Validator(label: label, value: value, required: true, min: 5)
            .validate();
        // Validator(label: label, value: value).minLength(5);
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
      autovalidate: _isSubmited ? true : false,
    );
  }

  Widget _buildDescriptionTextField() {
    String label = 'Product Desciption';
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product.description,
      decoration: InputDecoration(labelText: label),
      maxLines: 4,
      validator: (String value) {
        return Validator(label: label, value: value, required: true, min: 10)
            .validate();
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
      autovalidate: _isSubmited ? true : false,
    );
  }

  Widget _buildPriceTExtField() {
    String label = 'Product Price';
    return TextFormField(
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.numberWithOptions(),
      validator: (String value) {
        return Validator(
                label: label, value: value, required: true, isNumber: true)
            .validate();
        // Validator(label: label, value: value).isNumber();
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      autovalidate: _isSubmited ? true : false,
    );
  }

  Widget _buildPageContents(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTExtField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () => _onSubmit(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    setState(() {
      _isSubmited = true;
    });
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    Product data = Product(
        title: _formData['title'],
        price: _formData['price'],
        description: _formData['description'],
        image: _formData['image']);
    if (widget.product == null) {
      widget.addProduct(data);
    } else {
      widget.updateProduct(widget.productIndex, data);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return widget.product == null
        ? _buildPageContents(context)
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: _buildPageContents(context),
          );
  }
}
