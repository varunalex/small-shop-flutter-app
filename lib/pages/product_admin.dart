import 'package:flutter/material.dart';
import './product_edit.dart';
import './product_list.dart';

class ProductManageAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function updateProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;

  ProductManageAdminPage(
      this.addProduct, this.updateProduct, this.deleteProduct, this.products);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('All Products'),
                onTap: () => Navigator.pushNamed(context, '/products'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Product manage'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            EditProductPage(addProduct: addProduct),
            ProductListPage(products, updateProduct, deleteProduct),
          ],
        ),
      ),
    );
  }
}
