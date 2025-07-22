import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:crocurry/views/screens/profile/views/components/update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillingEditScreen extends StatefulWidget {
  const BillingEditScreen({super.key});

  @override
  State<BillingEditScreen> createState() => _BillingEditScreenState();
}

class _BillingEditScreenState extends State<BillingEditScreen> {
  final _formKey = GlobalKey<FormState>();

  UserModel? editingDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        
        centerTitle: true,
        title: const Text(
          'Billing Details',
          style: TextStyle(color: blackColor),
        ),
        titleSpacing: 0,
      ),
      bottomNavigationBar: UpdateButton(
        callback: () async {
          _formKey.currentState!.save();
          await CommonFunctions.updateUserDetails(context, editingDetails);
        },
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        editingDetails = state.user;
        var user = state.user!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding * 2),
            child: Form(
              key: _formKey,
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
                  TextFormField(
                    onSaved: (newValue) {
                      editingDetails!.billingAddress = newValue ?? "";
                    },
                    initialValue: user.billingAddress ?? "",
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
                      editingDetails!.billingCity = newValue;
                    },
                    initialValue: user.billingCity ?? "",
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
                      editingDetails!.billingState = newValue;
                    },
                    initialValue: user.billingState ?? "",
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
                      editingDetails!.billingCountry = newValue;
                    },
                    initialValue: user.billingCountry ?? "",
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
                      editingDetails!.billingZip = newValue;
                    },
                    initialValue: user.billingZip ?? "",
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_city,
                      ),
                      hintText: 'Zip',
                    ),
                  ),
                  // const SizedBox(height: defaultPadding),
                  // TextFormField(
                  //   onSaved: (newValue) {
                  //     editingDetails!.billingTelephone = newValue;
                  //   },
                  //   initialValue: user.billingTelephone ?? "",
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(
                  //       Icons.location_city,
                  //     ),
                  //     hintText: 'Telephone',
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: context.screenHeight * 0.15,
                  // ),
                  // CommonBtn(
                  //   onPressed: () async {
                  //     _formKey.currentState!.save();
                  //     editingDetails!.activationId = user.activationId ?? "";
                  //     editingDetails!.billingTelephone = user.userName ?? "";
                  //    await CommonFunctions.updateUserDetails(
                  //         context, editingDetails);
                  //   },
                  //   child: const Text('Update'),
                  // )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
