import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repositories/authentication/authentication_repository.dart';
import 'package:ecomm/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  // Singleton pattern to access the instance of AddressRepository
  static AddressRepository get instance => Get.find();

  // Reference to Firestore
  final _db = FirebaseFirestore.instance;

  // Method to fetch user addresses from Firestore
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      // Get the user ID from the authentication repository
      final userId = AuthenticationRepository.instance.authUser?.uid;
      print(userId);
      // Check if user ID is available
      if (userId == null || userId.isEmpty) {
        throw 'Unable to find user information. Please try again in a few minutes.';
      }

      // Fetch addresses from Firestore
      final result = await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .get();

      // Convert the Firestore documents to a list of AddressModel objects
      final address = result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();

      return address;
    } catch (e) {
      // Throw a descriptive error message if something goes wrong
      throw 'Something went wrong while fetching address information. Please try again later.';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      // Update the 'SelectedAddress' field in Firestore for the given address
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      // Handle the error by throwing a custom message
      throw 'Unable to update your address selection. Try again later.';
    }
  }

  /// Store new user address
  Future<String> addAddress(AddressModel address) async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      // Save the address to the 'Addresses' collection for the current user
      final currentAddress = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .add(address.toJson());

      // Return the newly created address document's ID
      return currentAddress.id;
    } catch (e) {
      // Throw an error with a more detailed message
      throw Exception(
          "Something went wrong while saving the address information. Please try again later.");
    }
  }
}
