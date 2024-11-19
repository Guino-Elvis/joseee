import 'package:flutter/material.dart';

class CheckoutProgress extends StatelessWidget {
  final Color colorItem;
  final bool progress;
  final textItem;

  const CheckoutProgress({
    Key? key,
    required this.colorItem,
    this.progress = false,
    this.textItem = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              textItem,
              style: TextStyle(
                color: colorItem,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (progress)
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorItem),
            strokeWidth: 6,
          ),
      ],
    );
  }
}
