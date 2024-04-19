import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/models/product.dart';
import 'package:foodapp/utilities/media_query_extension.dart';

class SearchListItem extends StatelessWidget {
  final Product searchResult;
  const SearchListItem({
    super.key,
    required this.searchResult,
  });

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
              searchResult.imgUrl,
              fit: BoxFit.cover,
              width: context.width * 0.35,
              height: context.height * 0.3,
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      searchResult.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          itemSize: 25.0,
                          rating: searchResult.rate?.toDouble() ?? 4.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            size: 35,
                            color: Color.fromARGB(255, 241, 217, 100),
                          ),
                          direction: Axis.horizontal,
                        ),
                        Text(
                          '${searchResult.price}\$',
                          style: Theme.of(context).textTheme.headlineLarge,
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
