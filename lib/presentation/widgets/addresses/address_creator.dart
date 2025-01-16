import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/domain/entities/place.dart';
import 'package:recyclomator/infrastructure/controllers/address_controller.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:recyclomator/presentation/widgets/places/place_search.dart';

class AddressCreator extends StatefulWidget {
  AddressCreator({super.key});

  final AddressController _addressController = GetIt.I<AddressController>();
  final UserService _userService = GetIt.I<UserService>();

  @override
  State<AddressCreator> createState() => _AddressCreatorState();
}

class _AddressCreatorState extends State<AddressCreator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  Place? _selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTitle(context, 'Create new address'),
        SizedBox(
          height: 300,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.text_snippet),
                    ),
                  ),
                  PlaceSearch(
                    onSelectPlace: _onSelectPlace,
                  ),
                  if (_selectedPlace != null)
                    Text(_selectedPlace!.formattedAddress),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedPlace == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No place selected')),
              );
              return;
            }

            final String name = _nameController.text;
            if (name == "") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Address name not set')),
              );
              return;
            }

            if (_formKey.currentState!.validate()) {
              final Address address = Address(
                userId: widget._userService.currentUserId,
                name: name,
                place: _selectedPlace!,
              );
              widget._addressController.addAddress(address);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Address $name created')),
              );

              _nameController.clear();
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

  void _onSelectPlace(Place place) {
    setState(() {
      _selectedPlace = place;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildTitle(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }
}
