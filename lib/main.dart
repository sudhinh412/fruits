import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/controllers/favorite/favourite_bloc.dart';
import 'package:fruits/controllers/favorite/favourite_event.dart';
import 'package:fruits/screens/item_detail_view.dart';
import 'package:fruits/screens/items_list.dart';
import 'package:fruits/widgets/product_card.dart';

import 'controllers/cart/cart_bloc.dart';
import 'controllers/fruits/fruits_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<FruitsBloc>(
        create: (BuildContext context) => FruitsBloc()..add(LoadFruits()),
      ),
      BlocProvider<CartBloc>(
        create: (BuildContext context) => CartBloc(),
      ),
      BlocProvider<FavoriteBloc>(
        create: (BuildContext context) => FavoriteBloc(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ItemList(),
    );
  }
}
