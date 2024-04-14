import 'package:flutter/material.dart';
import 'package:foodapp/utilities/media_query_extension.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/product.dart';
import '../../utilities/constants.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/main_button.dart';
import '../widgets/main_dialog.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  String dropdownValue = 'M';

  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        size: dropdownValue,
      );
      await database.addToCart(addToCartProduct);
      return MainDialog(
        context: context,
        title: 'Success',
        content: '${widget.product.title} added to the cart',
      ).showAlertDialog();
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: context.height * 0.55,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownMenuComponent(
                            items: const [
                              'S',
                              'M',
                              'L',
                            ],
                            hint: 'Size',
                            onChanged: (String? newValue) {
                              setState(() => dropdownValue = newValue!);
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: isFavorite ? Colors.teal : Colors.black45,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'mandi rice, beef, served with bread, sahaouk sauce yogurt pickles and your choice of one type of broth ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),
                  MainButton(
                    text: 'Add to cart',
                    onTap: () => _addToCart(context.read<Database>()),
                    hasCircularBorder: true,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
