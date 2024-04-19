import '../models/add_to_cart_model.dart';
import '../models/delivery_method.dart';
import '../models/product.dart';
import '../models/shipping_address.dart';
import '../models/user_data.dart';
import '../services/firestore_services.dart';
import '../utilities/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
  Stream<List<AddToCartModel>> myProductsCart();
  Stream<List<Product>> myProductsFavorites();
  Stream<List<DeliveryMethod>> deliveryMethodsStream();
  Stream<List<ShippingAddress>> getShippingAddresses();
  Future<void> setUserData(UserData userData);
  Future<void> addToCart(AddToCartModel product);
  Future<void> removeFromCart(String productId);
  Future<void> saveAddress(ShippingAddress address);
  Future<void> addToFavorites(Product product);
  Future<void> removefromFavorites(String productId);
  Stream<List<Product>> searchProductByTitle(String title);
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance;

  FirestoreDatabase(this.uid);

  Stream<List<Product>> productsStream() => _service.collectionsStream<Product>(
        path: 'products/',
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );

  @override
  Stream<List<Product>> salesProductsStream() =>
      _service.collectionsStream<Product>(
        path: 'products/',
        builder: (data, id) => Product.fromMap(data!, id),
      );

  @override
  Stream<List<Product>> newProductsStream() =>
      _service.collectionsStream<Product>(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  Future<void> setProduct(Product product) async => await _service.setData(
        path: 'products/${product.id}',
        data: product.toMap(),
      );

  @override
  Future<void> setUserData(UserData userData) async => await _service.setData(
        path: ApiPath.user(userData.uid),
        data: userData.toMap(),
      );

  @override
  Future<void> addToCart(AddToCartModel product) async => _service.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: product.toMap(),
      );

  @override
  Future<void> removeFromCart(String productId) async =>  _service.deleteData(
        path: ApiPath.addToCart(uid, productId),
      );

  @override
  Stream<List<AddToCartModel>> myProductsCart() =>
      _service.collectionsStream<AddToCartModel>(
        path: ApiPath.myProductsCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );

  @override
  Future<void> addToFavorites(Product product) async => _service.setData(
        path: ApiPath.addToFav(uid, product.id),
        data: product.toMap(),
      );

  @override
  Future<void> removefromFavorites(String productId) async =>
      _service.deleteData(
        path: ApiPath.addToFav(uid, productId),
      );

  @override
  Stream<List<Product>> myProductsFavorites() =>
      _service.collectionsStream<Product>(
        path: ApiPath.myProductsFav(uid),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  @override
  Stream<List<DeliveryMethod>> deliveryMethodsStream() =>
      _service.collectionsStream(
          path: ApiPath.deliveryMethods(),
          builder: (data, documentId) =>
              DeliveryMethod.fromMap(data!, documentId));

  @override
  Stream<List<ShippingAddress>> getShippingAddresses() =>
      _service.collectionsStream(
        path: ApiPath.userShippingAddress(uid),
        builder: (data, documentId) =>
            ShippingAddress.fromMap(data!, documentId),
      );

  @override
  Future<void> saveAddress(ShippingAddress address) => _service.setData(
        path: ApiPath.newAddress(
          uid,
          address.id,
        ),
        data: address.toMap(),
      );

  @override
  Stream<List<Product>> searchProductByTitle(String title) =>
      _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('title', isEqualTo: title),
      );
}
