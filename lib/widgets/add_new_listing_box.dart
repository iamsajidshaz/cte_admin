import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewListingBox extends StatelessWidget {
  final String listingName;
  final Color color;
  const AddNewListingBox({
    super.key,
    required this.listingName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: MediaQuery.of(context).size.width / 2 - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            listingName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            size: 24,
          )
        ],
      ),
    );
  }
}
