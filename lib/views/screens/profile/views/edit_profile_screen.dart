import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  UserModel? editingDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        // leadingWidth: 50,
        centerTitle: true,
        title: const Text(
          'Personal Details',
          style: TextStyle(color: blackColor),
        ),
        titleSpacing: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: CommonBtn(
          onPressed: () async {
            _formKey.currentState!.save();
            await CommonFunctions.updateUserDetails(context, editingDetails);
          },
          child: const Text('Update'),
        ),
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
                      editingDetails!.firstName = newValue;
                    },
                    initialValue: user.firstName!,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    onSaved: (newValue) {
                      editingDetails!.lastName = newValue;
                    },
                    initialValue: user.lastName!,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    onSaved: (newValue) {
                      editingDetails!.email = newValue;
                    },
                    initialValue: user.email!,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      hintText: 'Email',
                    ),
                  ),
                  // SizedBox(
                  //   height: context.screenHeight * 0.4,
                  // ),
                  // CommonBtn(
                  //   onPressed: () async {
                  //     _formKey.currentState!.save();
                  //     var actId = user.activationId ?? "";
                  //     debugPrint(" ## actId :$actId");
                  //     editingDetails!.activationId = user.activationId ?? "";
                  //     editingDetails!.userName = user.userName ?? "";
                  //     await CommonFunctions.updateUserDetails(
                  //         context, editingDetails);
                  //     // await locator<UpdateUserDetails>()
                  //     //     .call(editingDetails!)
                  //     //     .then((_) {
                  //     //   if (context.mounted) {
                  //     //     context
                  //     //         .read<UserBloc>()
                  //     //         .add(UpdateDetails(editingDetails!));
                  //     //     context.pop();
                  //     //   }
                  //     // });
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
