import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/controllers/address_controller.dart';

class AddressCreator extends StatefulWidget {
  AddressCreator({super.key});

  final AddressController _addressController = GetIt.I<AddressController>();

  @override
  State<AddressCreator> createState() => _AddressCreatorState();
}

class _AddressCreatorState extends State<AddressCreator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Create new address'),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(hintText: 'Street'),
                ),
                TextFormField(
                  controller: _houseNoController,
                  decoration: InputDecoration(hintText: 'House No'),
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(hintText: 'Country'),
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(hintText: 'City'),
                ),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: InputDecoration(hintText: 'Zip Code'),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final String name = _nameController.text;
              final Address address = Address(
                id: 'xd',
                userId: 'xy',
                name: name,
                street: _streetController.text,
                houseNo: _houseNoController.text,
                city: _cityController.text,
                country: _countryController.text,
                zipCode: _zipCodeController.text,
                lat: 12,
                lng: 12,
              );
              widget._addressController.addAddress(address);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Address $name created')),
              );

              _nameController.clear();
              _streetController.clear();
              _houseNoController.clear();
              _countryController.clear();
              _cityController.clear();
              _zipCodeController.clear();
              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed validating input!')),
            );
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _houseNoController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }
}
