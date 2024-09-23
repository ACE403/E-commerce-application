import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/utils/formatters/formatter.dart';

class AddressModel {
  String id; // Unique identifier for the address
  final String name; // Name of the person
  final String phoneNumber; // Phone number
  final String street; // Street address
  final String city; // City
  final String state; // State
  final String postalCode; // Postal/ZIP code
  final String country; // Country
  final DateTime?
      dateTime; // Date and time when the address was added or modified
  bool selectedAddress; // Flag to indicate if this address is selected

  // Constructor
  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true, // Default is true
  });

  // Static empty method that returns an empty AddressModel
  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '');

  String get formattedPhoneNo => Formatter.formatPhoneNumber(phoneNumber);

  // Method to convert AddressModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  // Factory constructor to create AddressModel from a Map
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
        id: data['Id'] as String,
        name: data['Name'] as String,
        phoneNumber: data['PhoneNumber'] as String,
        street: data['Street'] as String,
        city: data['City'] as String,
        state: data['State'] as String,
        postalCode: data['PostalCode'] as String,
        country: data['Country'] as String,
        selectedAddress: data['SelectedAddress'] as bool,
        dateTime: (data['DateTime'] as Timestamp).toDate());
  }

  // Factory constructor to create AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}
