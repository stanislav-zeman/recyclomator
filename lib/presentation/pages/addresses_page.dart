import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/domain/value_objects/address_component_type.dart';
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
        onData: (addresses) => _buildAddressPage(
          context,
          addresses,
        ),
      ),
    );
  }

  Widget _buildAddressPage(
    BuildContext context,
    List<Address> addresses,
  ) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
        SizedBox(height: 20),
        _buildExistingAddresses(
          context,
          addresses,
        ),
        Divider(),
        AddressCreator(),
      ],
    );
  }

  Widget _buildExistingAddresses(
    BuildContext context,
    List<Address> addresses,
  ) {
    return Column(
      children: [
        _buildTitle(
          context,
          "Existing addresses",
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 32.0,
          ),
          child: _buildAddressList(
            context,
            addresses,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressList(
    BuildContext context,
    List<Address> addresses,
  ) {
    if (addresses.isEmpty) {
      return Center(
        child: Text(
          'You do not have any addresses',
        ),
      );
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addresses.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          final Address address = addresses[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _buildAddressItem(
              address,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressItem(
    Address address,
  ) {
    return Wrap(
      spacing: 5,
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  address.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    address.place.addressComponents
                        .where(
                          (ac) =>
                              ac.types.contains(AddressComponentType.route) ||
                              ac.types.contains(
                                AddressComponentType
                                    .highLevelAdministrativeArea,
                              ) ||
                              ac.types.contains(
                                AddressComponentType.country,
                              ) ||
                              ac.types.contains(
                                AddressComponentType.streetNumber,
                              ),
                        )
                        .map(
                          (ac) => ac.shortText,
                        )
                        .join(" "),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _addressController.removeAddress(
                address.id!,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(
    BuildContext context,
    String text,
  ) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
