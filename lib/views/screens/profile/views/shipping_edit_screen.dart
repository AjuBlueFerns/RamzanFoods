import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/profile/views/components/update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingEditScreen extends StatefulWidget {
  const ShippingEditScreen({super.key});

  @override
  State<ShippingEditScreen> createState() => _ShippingEditScreenState();
}

class _ShippingEditScreenState extends State<ShippingEditScreen> {
  // final _formKey = GlobalKey<FormState>();

  UserModel? editingDetails;

  bool copyFromBilling = false;

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var user = editingDetails!;
      addressController.text = user.shippingAddress!;
      cityController.text = user.shippingCity!;
      stateController.text = user.shippingState!;
      countryController.text = user.shippingCountry!;
      zipController.text = user.shippingZip!;
      telephoneController.text = user.shippingTelephone!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Shipping Details',
          style: TextStyle(color: blackColor),
        ),
        titleSpacing: 0,
      ),
      bottomNavigationBar: UpdateButton(
        callback: () async {
          editingDetails!.shippingAddress = addressController.text;
          editingDetails!.shippingCity = cityController.text;
          editingDetails!.shippingState = stateController.text;
          editingDetails!.shippingCountry = countryController.text;
          editingDetails!.shippingZip = zipController.text;
          editingDetails!.shippingTelephone = telephoneController.text;
          await CommonFunctions.updateUserDetails(context, editingDetails);
        },
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        editingDetails = state.user;
        var user = state.user!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding / 2),
                CircleAvatar(
                  radius: defaultPadding * 3,
                  backgroundColor: primaryColor.withOpacity(0.5),
                  child: const Center(
                    child: Icon(Icons.person, size: defaultBorderRadius * 3),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Copy From Billing details'),
                    const SizedBox(width: defaultPadding),
                    Checkbox(
                      fillColor: WidgetStatePropertyAll(context.primaryColor),
                      value: copyFromBilling,
                      onChanged: (status) {
                        copyFromBilling = status!;

                        if (status) {
                          addressController.text = user.billingAddress!;
                          cityController.text = user.billingCity!;
                          stateController.text = user.billingState!;
                          countryController.text = user.billingCountry!;
                          zipController.text = user.billingZip!;
                          telephoneController.text = user.billingTelephone!;
                        } else {
                          addressController.clear();
                          cityController.clear();
                          stateController.clear();
                          countryController.clear();
                          zipController.clear();
                          telephoneController.clear();
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  onSaved: (newValue) {
                    editingDetails!.shippingAddress = newValue;
                  },
                  controller: addressController,
                  // initialValue: user.shippingAddress ?? "",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_pin,
                    ),
                    hintText: 'Address',
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  onSaved: (newValue) {
                    editingDetails!.shippingCity = newValue;
                  },
                  controller: cityController,
                  // initialValue: user.shippingCity ?? "",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                    ),
                    hintText: 'City',
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  onSaved: (newValue) {
                    editingDetails!.shippingState = newValue;
                  },
                  controller: stateController,
                  // initialValue: user.shippingState ?? "",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                    ),
                    hintText: 'State',
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  onSaved: (newValue) {
                    editingDetails!.shippingCountry = newValue;
                  },
                  controller: countryController,
                  // initialValue: user.shippingCountry ?? "",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                    ),
                    hintText: 'Country',
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  onSaved: (newValue) {
                    editingDetails!.shippingZip = newValue;
                  },
                  controller: zipController,
                  // initialValue: user.shippingZip ?? "",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                    ),
                    hintText: 'Zip',
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  onSaved: (newValue) {
                    editingDetails!.shippingTelephone = newValue;
                  },
                  controller: telephoneController,
                  // initialValue: user.shippingTelephone ?? "",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    hintText: 'Telephone',
                  ),
                ),
                // SizedBox(
                //   height: context.screenHeight * 0.15,
                // ),
                // CommonBtn(
                //   onPressed: () async {
                //     // _formKey.currentState!.save();
                //     editingDetails!.shippingAddress = addressController.text;
                //     editingDetails!.shippingCity = cityController.text;
                //     editingDetails!.shippingState = stateController.text;
                //     editingDetails!.shippingCountry = countryController.text;
                //     editingDetails!.shippingZip = zipController.text;
                //     editingDetails!.shippingTelephone =
                //         telephoneController.text;

                //     editingDetails!.activationId = user.activationId ?? "";
                //     editingDetails!.billingTelephone = user.userName ?? "";

                //     await CommonFunctions.updateUserDetails(
                //         context, editingDetails);
                //   },
                //   child: const Text('Update'),
                // )
              ],
            ),
          ),
        );
      }),
    );
  }
}
