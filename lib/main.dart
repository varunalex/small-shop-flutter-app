import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/product.dart';
import './scoped_models/products.dart';

import './pages/auth.dart';
import './pages/products.dart';
import './pages/product_admin.dart';
import './pages/product.dart';
import './pages/unKnown.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  build(BuildContext context) {
    return ScopedModel<ProductsModel>(
      model: ProductsModel(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.green,
        ),
        home: AuthPage(),
        routes: {
          '/products': (BuildContext build) => ProductsPage(),
          '/admin': (BuildContext context) => ProductManageAdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElement = settings.name.split('/');

          if (pathElement[0] != '') {
            return null;
          }

          if (pathElement[1] == 'product') {
            final int index = int.parse(pathElement[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return UnKnownPage();
            },
          );
        },
      ),
    );
  }
}
