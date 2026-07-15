
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/cart/cart_bloc.dart';
import '../controllers/cart/cart_event.dart';
import '../controllers/cart/cart_state.dart';
import '../controllers/favorite/favourite_bloc.dart';
import '../controllers/favorite/favourite_event.dart';
import '../controllers/favorite/favourite_state.dart';
import '../model/Fruits.dart';
import '../model/fruit_image_helper.dart';
import '../screens/item_detail_view.dart';

class ProductCard extends StatelessWidget {
  final Fruits fruit;

  const ProductCard({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailView(fruit: fruit),
          ),
        );
      },
      //card section starts here
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.all(12.0),
                        child: Image.network(FruitImageModel.getImage("${fruit.name}"),fit: .cover,),
                      ),
                    ),
                  ),

                  // Name section
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "${fruit.name}",
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Price section
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "₹${fruit.price}",
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (fruit.price! >3 && fruit.tag != null  )
                           Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "₹${(fruit.price! / 0.8).toStringAsFixed(0)}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "${fruit.quantity ?? 1} kg",
                      style:  TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                   SizedBox(height: 8),
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        final qty = state.getCount(fruit.id);
                        if (qty > 0) {
                          return _count(context, qty);
                        } else {
                          return _addButton(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            // tag Section

            if (fruit.price! > 3 && fruit.tag != null )
              Positioned(
                top: 16,
                left: 0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 100,
                      height: 22,
                      alignment: Alignment.centerLeft,
                      color: Colors.deepOrange,
                      padding:  EdgeInsets.only(left: 8),
                      child:  Text(
                        "${fruit.tag}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      right: -8,
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: Container(
                          width: 15,
                          height: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Favorite section
            Positioned(
              top: 5,
              right: 4,
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final isFav = state.isFavorite(fruit.id);
                  return IconButton(
                    iconSize: 20,
                    onPressed: () {
                      if (fruit.id != null) {
                        context.read<FavoriteBloc>().add(
                          ToggleFavorite(fruit.id!),
                        );
                      }
                    },
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.yellow : Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          context.read<CartBloc>().add(AddItem(fruit));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:  Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.zero,
        ),
        child:  Text(
          "ADD",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }

  Widget _count(BuildContext context, int qty) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: InkWell(

                onTap: () {
                  if (fruit.id != null) {
                    context.read<CartBloc>().add(DecrementItem(fruit.id!));
                  }
                },
                child:  Center(
                  child: Icon(Icons.remove, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),

          Container(
            width: 40,
            height: 35,
            alignment: .center,
            child: Text(
              "$qty",
              style:  TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          Expanded(
            child: Container(
              height: 35,
              decoration:  BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: InkWell(
                borderRadius:  BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                onTap: () {
                  if (fruit.id != null) {
                    context.read<CartBloc>().add(IncrementItem(fruit.id!));
                  }
                },
                child:  Center(
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
