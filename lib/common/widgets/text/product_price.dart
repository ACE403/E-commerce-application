import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign = '\$',
    required this.price,
    this.maxlines = 1,
    this.isLarge = false,
    this.linethrough = false,
  });
  final String currencySign, price;
  final int maxlines;
  final bool isLarge;
  final bool linethrough;

  @override
  Widget build(BuildContext context) {
    return Text(currencySign + price,
        maxLines: maxlines,
        overflow: TextOverflow.ellipsis,
        style: isLarge
            ? Theme.of(context).textTheme.headlineMedium!.apply(
                decoration: linethrough ? TextDecoration.lineThrough : null)
            : Theme.of(context).textTheme.titleLarge!.apply(
                decoration: linethrough ? TextDecoration.lineThrough : null));
  }
}
