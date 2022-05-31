
class Listing {
  Listing({required this.id, required this.name, required this.price});
  final String id;
  final String name;
  final int? price;


  ////originally factory
    static Listing? fromMap(Map<String, dynamic>? data, String documentId){
    if(data == null) {
      return null;
  }
    final String name = data['name'];
    final int price = data['price'];
    return Listing(
      id: documentId,
      name: name,
      price: price,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'price': price,
    };
  }

}