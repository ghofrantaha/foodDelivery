import '../utilities/assets.dart';

class Product {
  final String id;
  final String title;
  final int price;
  final String imgUrl;
  final int? discountValue;
  final String category;
  final int? rate;
  final String description;
  final int calories;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    required this.calories,
    required this.description,
    this.discountValue,
    this.category = 'Other',
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,
      'calories': calories,
      'description': description
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      category: map['category'],
      discountValue: map['discountValue'],
      imgUrl: map['imgUrl'],
      price: map['price'],
      title: map['title'],
      rate: map['rate'],
      calories: map['calories'],
      description: map['description'],
    );
  }
}

List<Product> productsList = [
  Product(
    id: '1',
    title: '39ertime',
    price: 9,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Crepe    ',
    discountValue: 20,
    calories: 23,
  ),
  Product(
    id: '1',
    title: 'alhalawany',
    price: 30,
    imgUrl: AppAssets.tempProductAsset2,
    category: 'cake   ',
    discountValue: 20,
    calories: 96,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '2',
    title: 'vikingBurger',
    price: 6,
    imgUrl: AppAssets.tempProductAsset6,
    category: 'burger ',
    discountValue: 20,
    calories: 36,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '3',
    title: 'Khan.mandi',
    price: 30,
    imgUrl: AppAssets.tempProductAsset3,
    category: 'mandi chicken ',
    discountValue: 20,
    calories: 85,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '3',
    title: 'Khan.mandi',
    price: 30,
    imgUrl: AppAssets.tempProductAsset3,
    category: 'mandi chicken ',
    discountValue: 20,
    calories: 96,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '3',
    title: 'Khan.mandi',
    price: 30,
    imgUrl: AppAssets.tempProductAsset3,
    category: 'mandi chicken ',
    discountValue: 20,
    calories: 89,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '4',
    title: '39ertime',
    price: 7,
    imgUrl: AppAssets.tempProductAsset4,
    category: 'Oreo milkshake ',
    calories: 50,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '5',
    title: 'na3na3rest',
    price: 15,
    imgUrl: AppAssets.tempProductAsset5,
    category: 'Dolma ',
    discountValue: 20,
    calories: 63,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '5',
    title: 'Khan.mandi',
    price: 30,
    imgUrl: AppAssets.tempProductAsset7,
    category: 'mandi meat ',
    discountValue: 20,
    calories: 110,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Product(
    id: '5',
    title: 'super chicken',
    price: 6,
    imgUrl: AppAssets.tempProductAsset8,
    category: 'Zenker ',
    discountValue: 20,
    calories: 98,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
];
