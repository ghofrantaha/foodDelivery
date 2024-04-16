import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/models/product.dart';
import 'package:foodapp/utilities/media_query_extension.dart';

class FavListItem extends StatelessWidget {
  final Product favItem;
  const FavListItem({
    super.key,
    required this.favItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.network(
                favItem.imgUrl,
                fit: BoxFit.cover,
                width: context.width * 0.35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        favItem.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          itemSize: 25.0,
                          rating: favItem.rate?.toDouble() ?? 4.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 241, 217, 100),
                          ),
                          direction: Axis.horizontal,
                        ),
                        Text(
                          '${favItem.price}\$',
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
