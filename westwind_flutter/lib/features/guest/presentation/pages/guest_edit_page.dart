import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';

class GuestEditPage extends StatefulWidget {
  final int? guestId;
  static String route([int? guestId]) => "/guests/edit/${guestId ?? ':id'}";
  static String routeNew() => "/guests/new";


  const GuestEditPage({super.key, this.guestId});

  @override
  State<GuestEditPage> createState() => _GuetEditPageState();
}

class _GuetEditPageState extends State<GuestEditPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();


  final formkey = GlobalKey<FormState>();

  bool get isEditing {
    return widget.guestId != null && widget.guestId! > 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (isEditing) {
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveEvent(id: widget.guestId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Guest Edit")),
        body: BlocConsumer<GuestManageBloc, GuestManageState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GuestManageStateLoading ) {
              //return const Loader();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        decoration:
                            const InputDecoration(label: Text('FirstName')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'FirstName required';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration:
                            const InputDecoration(label: Text('last name')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'last name required';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(label: Text('Email')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email required';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(label: Text('phone')),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'phone required';
                          }

                          if (int.tryParse(value) == null) {
                            return 'Invalid phone';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
