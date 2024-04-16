import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/utilities/media_query_extension.dart';
import 'package:foodapp/views/widgets/main_dialog.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/product.dart';
import '../../utilities/routes.dart';

class ListItemHome extends StatefulWidget {
  final Product product;
  final bool isNew;

  const ListItemHome({
    super.key,
    required this.product,
    required this.isNew,
  });

  @override
  State<ListItemHome> createState() => _ListItemHomeState();
}

class _ListItemHomeState extends State<ListItemHome> {
  bool isFavorite = false;

  Future<void> _addToFavorites(Database database) async {
    try {
      await database.addToFavorites(widget.product);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to Favorites, please try again!',
      ).showAlertDialog();
    }
  }

  Future<void> _removefromFavorites(Database database) async {
    try {
      await database.removefromFavorites(widget.product.id);
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
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetailsRoute,
        arguments: {
          'product': widget.product,
          'database': context.read<Database>(),
        },
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.product.imgUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: widget.isNew
                        ? Colors.black
                        : const Color.fromARGB(255, 244, 124, 54),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        widget.isNew
                            ? 'NEW'
                            : '${widget.product.discountValue}%',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: context.width * 0.38,
            bottom: context.height * 0.12,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: InkWell(
                  onTap: () {
                    if (isFavorite)
                      _removefromFavorites(context.read<Database>());
                    else
                      _addToFavorites(context.read<Database>());
                    setState(() => isFavorite = !isFavorite);
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: 20,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 25.0,
                      rating: widget.product.rate?.toDouble() ?? 4.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 241, 217, 100),
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(100)',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.product.category,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 6.0),
                Text(
                  widget.product.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6.0),
                widget.isNew
                    ? Text(
                        '${widget.product.price}\$',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${widget.product.price}\$  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '  ${widget.product.price * (widget.product.discountValue!) / 100}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
