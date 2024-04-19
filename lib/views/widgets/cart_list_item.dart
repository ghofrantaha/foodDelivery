import 'package:flutter/material.dart';
import 'package:foodapp/controllers/database_controller.dart';
import 'package:foodapp/utilities/media_query_extension.dart';
import 'package:foodapp/views/widgets/main_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/add_to_cart_model.dart';

class CartListItem extends StatefulWidget {
  final AddToCartModel cartItem;
  const CartListItem({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  Future<void> _removefromCart(Database database) async {
    try {
      await database.removeFromCart(widget.cartItem.id);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t removing from Favorites, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.network(
                widget.cartItem.imgUrl,
                fit: BoxFit.cover,
                width: context.width * 0.35,
                height: context.height * 0.3,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.more_vert),
                  IconButton(
                    onPressed: () => _removefromCart(context.read<Database>()),
                    icon: const Icon(Icons.delete),
                  ),
                  Text(
                    '${widget.cartItem.price}\$',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
