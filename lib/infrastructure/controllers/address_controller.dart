import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';

class AddressController {
  AddressController(
    this._userService,
    this._addressRepository,
  );

  final UserService _userService;
  final FirestoreRepository<Address> _addressRepository;

  Stream<List<Address>> get userAddresses => _addressRepository.observeDocuments().map(
        (List<Address> addresses) => addresses
            .where(
              (Address address) => address.userId == _userService.currentUserId,
            )
            .toList(),
      );

  void addAddress(Address address) {
    _addressRepository.add(address);
  }

  Future<void> removeAddress(String id) async {
    await _addressRepository.delete(id);
  }
}
