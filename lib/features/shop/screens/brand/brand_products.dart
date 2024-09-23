import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/brands/brand_card.dart';
import 'package:ecomm/common/widgets/products/sortable/sortable.dart';
import 'package:ecomm/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecomm/features/shop/controllers/brand_controller.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: CustomAppbar(
        title: Text(brand.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Brand detail
              BrandCard(
                showborder: true,
                brand: brand,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    const loader = VerticalProductShimmer();
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                    );
                    if (widget != null) return widget;
                    final BrandProducts = snapshot.data!;
                    return SortableProducts(
                      products: BrandProducts,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
