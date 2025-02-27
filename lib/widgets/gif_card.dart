import 'package:flutter/material.dart';

class GifCard extends StatelessWidget {
  final List<String> gifs;
  const GifCard({
    super.key,
    required this.gifs,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        itemCount: gifs.length,
        itemBuilder: (context, index) {
          return Image.network(
            gifs[index],
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 10,
            color: Colors.transparent,
          );
        },
      ),
    );
  }
}
