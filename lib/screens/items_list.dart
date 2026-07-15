import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/fruits/fruits_bloc.dart';

import '../widgets/product_card.dart';


class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Fruits and Vegetables',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: BlocBuilder<FruitsBloc, FruitsState>(
        builder: (context, state) {
          if (state is FruitsLoading) {
            return  Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
          if (state is FruitsError) {
            return Center(child: Text(state.errmsg));
          }
          if (state is FruitsLoaded) {
            if (state.fruits.isEmpty) {
              return const Center(child: Text("No data available"));
            }
            return GridView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: state.fruits.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final fruit = state.fruits[index];
                //Product card desgin
                return ProductCard(fruit: fruit);
              },
            );
          }
          return  SizedBox.shrink();
        },
      ),
    );
  }
}
