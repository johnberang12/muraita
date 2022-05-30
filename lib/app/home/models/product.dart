
class Product{
  Product({required this.name, required this.price});
  final String name;
  final int price;

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'price': price,
    };
  }

}