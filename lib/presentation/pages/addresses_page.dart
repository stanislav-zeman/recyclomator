import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/controllers/address_controller.dart';
import 'package:recyclomator/presentation/templates/page_template.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';
import 'package:recyclomator/presentation/widgets/places/place_search.dart';

class AddressesPage extends StatelessWidget {
  AddressesPage({super.key});

  final AddressController _addressController = GetIt.I<AddressController>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Addresses'),
      child: StreamWidget(
        stream: _addressController.userAddresses,
        onData: (addresses) => _buildAddressPage(context, addresses),
      ),
    );
  }

  Widget _buildAddressPage(BuildContext context, List<Address> addresses) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
        SizedBox(height: 20),
        _buildExistingAddresses(context, addresses),
        Divider(),
        PlaceSearch(),
        // AddressCreator(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildExistingAddresses(BuildContext context, List<Address> addresses) {
    return Column(
      children: [
        _buildTitle(context, "Existing addresses"),
        Padding(
          padding: EdgeInsets.all(32.0),
          child: _buildAddressList(context, addresses),
        ),
      ],
    );
  }

  Widget _buildAddressList(BuildContext context, List<Address> addresses) {
    if (addresses.isEmpty) {
      return Center(child: Text('You do not have any addresses'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (BuildContext context, int index) {
        final Address address = addresses[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildAddressItem(address),
        );
      },
    );
  }

  Widget _buildAddressItem(Address address) {
    return Wrap(
      spacing: 5,
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  address.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${address.street} ${address.houseNo}"),
                Text("${address.city} ${address.zipCode} ${address.country}"),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _addressController.removeAddress(address.id),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }
}
