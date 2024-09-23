import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import 'widgets/overall_product_rating.dart';
import 'widgets/rating_progress_indicator.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Text("Reviews and Ratings"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Rating and reviews are verified and are from people who use the same type of device that u use."),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            //Overall Product rating
            OverallProductRating(),
            TRatingBarIndicator(
              rating: 4.8,
            ),
            Text(
              "12,611",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // User rating list
            UserReviewCard(),
            UserReviewCard()
          ],
        ),
      ),
    );
  }
}
