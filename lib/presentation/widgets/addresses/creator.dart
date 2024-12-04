import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';

class AddressCreator extends StatefulWidget {
  final FirestoreRepository<Address> addressRepository;

  const AddressCreator({super.key, required this.addressRepository});

  @override
  State<AddressCreator> createState() => _AddressCreatorState();
}

class _AddressCreatorState extends State<AddressCreator> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseNoController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Create new address"),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(hintText: "Street"),
                ),
                TextFormField(
                  controller: _houseNoController,
                  decoration: InputDecoration(hintText: "House No"),
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(hintText: "Country"),
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(hintText: "City"),
                ),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: InputDecoration(hintText: "Zip Code"),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final name = _nameController.text;
              final address = Address(
                id: "xd",
                userId: "xy",
                name: name,
                street: _streetController.text,
                houseNo: _houseNoController.text,
                city: _cityController.text,
                country: _countryController.text,
                zipCode: _zipCodeController.text,
              );
              widget.addressRepository.add(address);
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
