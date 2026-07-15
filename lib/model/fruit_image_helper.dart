class FruitImageModel {
  static const Map<String, String> images = {
    "apple":
    "https://static.vecteezy.com/system/resources/previews/020/899/515/non_2x/red-apple-isolated-on-white-png.png",
    "banana":
    "https://pngimg.com/uploads/banana/banana_PNG824.png",
    "orange":
    "https://images.unsplash.com/photo-1547514701-42782101795e?w=500",
    "mango":
    "https://images.unsplash.com/photo-1553279768-865429fa0078?w=500",
    "grapes":
    "https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=500",
    "pineapple":
    "https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=500",
    "watermelon":
    "https://images.unsplash.com/photo-1563114773-84221bd62daa?w=500",
    "strawberry":
    "https://upload.wikimedia.org/wikipedia/commons/9/96/Strawberry-icon-1000px.png",
    "kiwi":
    "https://images.unsplash.com/photo-1585059895524-72359e06133a?w=500",
    "papaya":
    "https://images.unsplash.com/photo-1517282009859-f000ec3b26fe?w=500",
  };

  static String getImage(String name) {
    return images[name.toLowerCase()] ??
        "https://via.placeholder.com/300x300.png?text=Fruit";
  }
}