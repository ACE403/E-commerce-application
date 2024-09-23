import 'package:ecomm/data/repositories/banner/banner_repository.dart';
import 'package:ecomm/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../data/repositories/category/category_repository.dart';
import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  final Carouselcurrentindex = 0.obs;

  void pageUpdateIndicator(index) {
    Carouselcurrentindex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      //show loaders while loading
      isLoading.value = true;

      final bannersRepo = Get.put(BannerRepository());

      final banners = await bannersRepo.fetchBanners();
      this.banners.assignAll(banners);
      print(banners);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
