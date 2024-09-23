import 'package:ecomm/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:flutter/material.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 6,
          child: Column(
            children: [
              RaingProgressIndicator(
                text: '5',
                value: 1,
              ),
              RaingProgressIndicator(
                text: '4',
                value: 0.8,
              ),
              RaingProgressIndicator(
                text: '3',
                value: 0.6,
              ),
              RaingProgressIndicator(
                text: '2',
                value: 0.4,
              ),
              RaingProgressIndicator(
                text: '1',
                value: 0.2,
              )
            ],
          ),
        )
      ],
    );
  }
}
