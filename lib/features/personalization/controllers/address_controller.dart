import 'dart:ui';

import 'package:ecomm/features/personalization/models/address_model.dart';
import 'package:ecomm/features/personalization/screens/address/add_new_address.dart';
import 'package:ecomm/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecomm/utils/popups/full_screen_loader.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text/section_heading.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';

class AddressController extends GetxController {
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  RxBool refreshData = true.obs;
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  // Singleton pattern for easy access to the controller
  static AddressController get instance => Get.find();

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  // Reference to AddressRepository using GetX's dependency injection
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user-specific addresses
  Future<List<AddressModel>> getallUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      print(' controller: $addresses');
      return addresses;
    } catch (e) {
      // Display an error snackbar in case of an exception
      Loaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
      return []; // Return an empty list if an error occurs
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Check if there is a currently selected address to clear
      if (selectedAddress.value.id.isNotEmpty) {
        // Clear the "selected" field of the currently selected address
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      // Assign the new selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      // Handle the error by showing a snackbar or throwing an error
      Loaders.errorSnackBar(
        title: 'Error in Selection',
        message: e.toString(),
      );
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true, // Allow the bottom sheet to expand if necessary
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: TSizes.lg,
          right: TSizes.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + TSizes.lg,
        ), // Adjust for the keyboard and padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Make the bottom sheet adapt to the content
          children: [
            const SectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Fetch addresses using FutureBuilder
            FutureBuilder(
              future: getallUserAddresses(), // Function to fetch user addresses
              builder: (_, snapshot) {
                final response = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);

                // If there is a response from the helper (like loader, error), show it
                if (response != null) return response;

                // If data is available, display the addresses
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const ClampingScrollPhysics(), // Avoid internal scrolling
                    itemCount: snapshot.data!.length, // Number of addresses
                    itemBuilder: (_, index) => SingleAddress(
                      address:
                          snapshot.data![index], // Address at the given index
                      onTap: () async {
                        await selectAddress(
                            snapshot.data![index]); // Handle selection
                        Get.back(); // Close the bottom sheet
                      },
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: TSizes.defaultSpace * 2),

            // Add new address button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => AddNewAddress()),
                child: const Text('Add new Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Add new Address
  Future<void> addNewAddress() async {
    try {
      // Start loading with a message
      FullScreenLoader.openloadingDialog('Storing Address...', TImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
            title: 'No Internet',
            message: 'Please check your internet connection.');
        return;
      }

      // Form validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
            title: 'Invalid Form',
            message: 'Please fill all fields correctly.');
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '', // This will be set after saving
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true, // Mark it as selected by default
      );

      // Save the address and get the generated ID from the repository
      final id = await addressRepository.addAddress(address);

      // Update the ID of the newly created address
      address.id = id;

      // Update the selected address status
      await selectAddress(address);

      // Stop loading after completion
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been saved successfully.',
      );

      // Refresh Address Data
      refreshData.toggle();

      // Reset the form fields
      resetFormFields();

      // Redirect back to the previous screen
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Stop loading and show error in case of exception
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
    }
  }

  /// Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
