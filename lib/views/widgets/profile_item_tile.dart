import 'package:flutter/material.dart';

class ProfileItemTile extends StatelessWidget {
  final String title, content;

  const ProfileItemTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(content,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black54)),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
