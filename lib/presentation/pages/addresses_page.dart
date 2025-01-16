import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/controllers/address_controller.dart';
import 'package:recyclomator/presentation/templates/page_template.dart';
import 'package:recyclomator/presentation/widgets/addresses/address_creator.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';

class AddressesPage extends StatelessWidget {
  AddressesPage({super.key});

  final AddressController _addressController = GetIt.I<AddressController>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Addresses'),
      child: StreamWidget(
        stream: _addressController.userAddresses,
        onData: _buildAddressPage,
      ),
    );
  }

  Widget _buildAddressItem(Address address) {
    return Wrap(
      spacing: 5,
      children: <Widget>[
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
          onPressed: () => _addressController.removeAddress(address.id),
          child: Text('Delete'),
        ),
      ],
    );
  }

  Widget _buildAddressList(List<Address> addresses) {
    if (addresses.isEmpty) {
      return Center(child: Text('You do not have any addresses'));
    }

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: addresses.length,
            itemBuilder: (BuildContext context, int index) {
              final Address address = addresses[index];
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

  Widget _buildAddressPage(List<Address> addresses) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
        SizedBox(height: 20),
        _buildAddressList(addresses),
        Divider(),
        AddressCreator(),
        SizedBox(height: 20),
      ],
    );
  }
}
