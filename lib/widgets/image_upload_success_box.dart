import 'package:flutter/material.dart';

class ImageUploadedSuccessBox extends StatelessWidget {
  final String num;
  const ImageUploadedSuccessBox({
    super.key,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green)),
          child: Center(child: Text("Image $num uploaded successfully"))),
    );
  }
}
