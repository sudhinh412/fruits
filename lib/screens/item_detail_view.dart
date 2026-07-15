import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/cart/cart_bloc.dart';
import '../controllers/cart/cart_event.dart';
import '../controllers/cart/cart_state.dart';
import '../model/Fruits.dart';
import '../model/fruit_image_helper.dart';

class ItemDetailView extends StatelessWidget {
  final Fruits fruit;

  const ItemDetailView({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // image section mapped with fruit.name, fruit_image_helper.dart is the file name. based on the name image will show
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                    color: Colors.grey.shade300, image: DecorationImage(
                    image:  NetworkImage(FruitImageModel.getImage(fruit.name ?? ""),),
                    fit: BoxFit.cover,

                  ),

                ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon:  Icon(Icons.arrow_back_ios, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
             SizedBox(height: 20),

            // Name section
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${fruit.name}" ,
                          style:  TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          final qty = state.getCount(fruit.id);
                          if (qty > 0) {
                            // widget model for count
                            return _count(context, qty);
                          } else {
                            // widget model for add button
                            return _addButton(context);
                          }
                        },
                      ),
                    ],
                  ),

                  // Price section
                  Text(
                    "₹${fruit.price}",
                    style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  // Quantity section
                  Text(
                    "${fruit.quantity ?? 1} g",
                    style:  TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                   SizedBox(height: 20),
                  // About section
                   Text(
                    "About",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   SizedBox(height: 8),
                  // Description section
                  Text(
                    "${fruit.description}",
                    style:  TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                   SizedBox(height: 25),


                  // Benifits section
                  if (fruit.benefits != null && fruit.benefits!.isNotEmpty) ...[
                     Text(
                      "Benefits",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 15),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: fruit.benefits!.length,
                        itemBuilder: (context, index) {
                          final benefit = fruit.benefits![index];
                          return Container(
                            width: 100,
                            margin:  EdgeInsets.only(right: 15),
                            child: Column(
                              children: [
                                Container(
                                  padding:  EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.green.withOpacity(0.8),
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      "${benefit.image}" ,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                 SizedBox(height: 8),
                                Text(
                                  "${benefit.name}" ,
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                   SizedBox(height: 20),


                  // Relevant Recipes section
                  if (fruit.recipes != null && fruit.recipes!.isNotEmpty) ...[
                     Text(
                      "Relevant Recipes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 15),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: fruit.recipes!.length,
                        itemBuilder: (context, index) {
                          final recipe = fruit.recipes![index];
                          return Container(
                            width: 300,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${recipe.image}" ,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              padding:  EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${recipe.name}" ,
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                   Text(
                                    "Chef Ramsay",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                   SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add button
  Widget _addButton(BuildContext context) {
    return SizedBox(

      height: 32,
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

  // Increment and decrement section
  Widget _count(BuildContext context, int qty) {
    return Container(

      height: 32,
      decoration: BoxDecoration(
        color:  Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (fruit.id != null) {
                context.read<CartBloc>().add(DecrementItem(fruit.id!));
              }
            },
            padding: EdgeInsets.zero,
            icon:  Icon(Icons.remove, color: Colors.white, size: 16),
          ),
          Text(
            "$qty",
            style:  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          IconButton(
            onPressed: () {
              if (fruit.id != null) {
                context.read<CartBloc>().add(IncrementItem(fruit.id!));
              }
            },
            padding: EdgeInsets.zero,
            icon:  Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}
