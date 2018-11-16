import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './../models/product.dart';
import './../scoped_models/connected_models.dart';

import './../validation/validation.dart';

class EditProductPage extends StatefulWidget {
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

  Widget _buildTitleTextField(Product product) {
    String label = 'Product title';
    return TextFormField(
      initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionTextField(Product product) {
    String label = 'Product Desciption';
    return TextFormField(
      initialValue: product == null ? '' : product.description,
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

  Widget _buildPriceTExtField(Product product) {
    String label = 'Product Price';
    return TextFormField(
      initialValue: product == null ? '' : product.price.toString(),
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

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return RaisedButton(
          child: Text('Save'),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          onPressed: () => _onSubmit(model.addProduct, model.updateProduct,
              model.selectProduct, model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildPageContents(BuildContext context, Product product) {
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
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTExtField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    setState(() {
      _isSubmited = true;
    });
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(_formData['title'], _formData['description'],
          _formData['price'], _formData['image']);
    } else {
      updateProduct(_formData['title'], _formData['description'],
          _formData['price'], _formData['image']);
    }

    Navigator.pushReplacementNamed(context, '/products')
        .then((_) => setSelectedProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return model.selectedProductIndex == null
            ? _buildPageContents(context, model.selectedProduct)
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: _buildPageContents(context, model.selectedProduct),
              );
      },
    );
  }
}
