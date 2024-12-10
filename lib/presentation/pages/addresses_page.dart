import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/presentation/templates/page_template.dart';
import 'package:recyclomator/presentation/widgets/addresses/creator.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';

class AddressesPage extends StatelessWidget {
  final FirestoreRepository<Address> addressRepository;

  const AddressesPage({super.key, required this.addressRepository});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text("Addresses"),
      child: StreamWidget(
          stream: addressRepository.observeDocuments(),
          onData: _buildAddressPage),
    );
  }

  Widget _buildAddressPage(List<Address> addresses) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(height: 20),
        _buildAddressList(addresses),
        Divider(),
        AddressCreator(
          addressRepository: addressRepository,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAddressList(List<Address> addresses) {
    if (addresses.isEmpty) {
      return Center(child: Text("You do not have any addresses"));
    }

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _buildAddressItem(address),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(Address address) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 5,
      children: [
        Text(
          address.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 4),
        Text(address.street),
        Text(address.houseNo),
        Text(address.city),
        Text(address.zipCode),
        Text(address.country),
        SizedBox(width: 16),
        ElevatedButton(
            onPressed: () => addressRepository.delete(address.id),
            child: Text("Delete"))
      ],
    );
  }
}
