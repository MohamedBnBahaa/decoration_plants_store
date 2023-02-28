class Item{
  String imgPath;
  double price;
  String location;
  String name;

  Item({required this.name, required this.imgPath, required this.price, this.location = "Main branch",});
}

final List<Item> items = [
  Item(name:"Product_01", imgPath: "assets/images/1.webp", price: 312.99, location: "Decoration shop",),
  Item(name:"Product_02", imgPath: "assets/images/2.webp", price: 212.99,),
  Item(name:"Product_03", imgPath: "assets/images/3.webp", price: 512.99,),
  Item(name:"Product_04", imgPath: "assets/images/4.webp", price: 412.99, location: "Ali shop",),
  Item(name:"Product_05", imgPath: "assets/images/5.webp", price: 312.99,),
  Item(name:"Product_06", imgPath: "assets/images/6.webp", price: 212.99, location: "Ali shop",),
  Item(name:"Product_07", imgPath: "assets/images/7.webp", price: 512.99, location: "Ali shop",),
  Item(name:"Product_08", imgPath: "assets/images/8.webp", price: 612.99,),
  Item(name:"Product_09", imgPath: "assets/images/1.webp", price: 712.99,),
  Item(name:"Product_10", imgPath: "assets/images/2.webp", price: 212.99,),
  Item(name:"Product_11", imgPath: "assets/images/3.webp", price: 512.99, location: "Ali shop",),
  Item(name:"Product_12", imgPath: "assets/images/4.webp", price: 312.99,),
  Item(name:"Product_13", imgPath: "assets/images/5.webp", price: 412.99,),
  Item(name:"Product_14", imgPath: "assets/images/6.webp", price: 212.99,),
  Item(name:"Product_15", imgPath: "assets/images/7.webp", price: 312.99, location: "Decoration shop",),
  Item(name:"Product_16", imgPath: "assets/images/8.webp", price: 412.99, location: "Decoration shop",),
];