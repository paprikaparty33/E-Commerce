import 'dart:convert';

class Album {
   String? id;
   String name;
   double price;
   double quantity;
   String location;
   String status;
   String description;
   List<String> images;
   bool isNewArrival;
   bool isPopular;
   String category;

  //TODO: у каждого альбома 2 изображения: мейн и дескрипшн имадж
  //TODO: 5:35 miltipleAdmins bu using userID 

  Album(
     {
  required this.isPopular,
       required this.category,
    required this.price,
    required this.quantity,
    required this.location,
    required this.status,
    required this.description,
    required this.images,
     this.id,
    required this.name,
    required this.isNewArrival,
  });

  String getDeliveryTime(String locat, String stat){
    if(location=='KR' && status=='Pre-order'){
      return '60-90 days';
    }else if(location=='KR' && status=='In stock'){
      return  '30-60 days';
    }else if(location=='KR' && status=='Sold out'){
      return ' ';
    }else if(location=='RU' && status=='In stock'){
      return '15-30 days';
    }else {
      return 'Not available';
    }
  }
  Map<String, dynamic> toMap() {

    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'price': price,
      '_id': id,
      'location': location,
      'status': status,
      'isNewArrival': isNewArrival,
      'isPopular': isPopular,
      'category': category,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      location: map['location'] ?? '',
      status: map['status'] ?? '',
      isNewArrival: map['isNewArrival'] ?? '',
        isPopular: map['isPopular'] ?? '',
        category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));
}
