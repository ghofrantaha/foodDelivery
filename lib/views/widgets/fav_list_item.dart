import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/controllers/database_controller.dart';
import 'package:foodapp/models/product.dart';
import 'package:foodapp/utilities/media_query_extension.dart';
import 'package:foodapp/views/widgets/main_dialog.dart';
import 'package:provider/provider.dart';

class FavListItem extends StatefulWidget {
  final Product favItem;
  const FavListItem({
    super.key,
    required this.favItem,
  });
  @override
  State<FavListItem> createState() => _FavListItemState();
}

class _FavListItemState extends State<FavListItem> {
  Future<void> _removefromFavorites(Database database) async {
    try {
      await database.removefromFavorites(widget.favItem.id);
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: [
            Image.network(
              widget.favItem.imgUrl,
              fit: BoxFit.cover,
              width: context.width * 0.35,
              height: context.height * 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: context.width * 0.45,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.width * 0.3,
                          child: Text(
                            widget.favItem.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(
                          onPressed: () async =>
                              _removefromFavorites(context.read<Database>()),
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          itemSize: 25.0,
                          rating: widget.favItem.rate?.toDouble() ?? 4.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 241, 217, 100),
                          ),
                          direction: Axis.horizontal,
                        ),
                        Text(
                          '${widget.favItem.price}\$',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
