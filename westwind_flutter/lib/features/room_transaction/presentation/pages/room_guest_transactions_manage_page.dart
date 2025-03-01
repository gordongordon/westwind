import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/app_form_fields.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/pdf_edit.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_guest_transactions_manage_widget.dart';

class RoomGuestTransactionsManagePage extends StatefulWidget {
  final int? roomGuestId;

  static String route([int? roomGuestId]) =>
      "/roomguesttransactionsmanage/edit/${roomGuestId ?? ':id'}";

  const RoomGuestTransactionsManagePage({super.key, this.roomGuestId});

  @override
  State<RoomGuestTransactionsManagePage> createState() =>
      _RoomGuestTransactionsManagePage();
}

class _RoomGuestTransactionsManagePage
    extends State<RoomGuestTransactionsManagePage> {
  late String firstName;
  late String lastName;
  late int roomNumber;

  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstName = "Gordon";
    lastName = "Wong";
    roomNumber = 0;
    if (widget.roomGuestId != null) {
      context.read<RoomGuestManageBloc>().add(
            RetrieveRoomGuest(widget.roomGuestId!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Room Transaction - $firstName $lastName - Room # ${roomNumber.toString()}"),
        actions: const [
          AppUserDropdown(),
        ],
      ),
      //    floatingActionButton: FloatingActionButton(onPressed: () {
      //         context.push(RoomTransactionEditPage.routeNew());
      //    },child: const Icon( Icons.add),),

      //  body: RoomGuestTransactionsManageWidget(roomGuestId: widget.roomGuestId ?? 0 ),

      body: BlocConsumer<RoomGuestManageBloc, RoomGuestManageState>(
        listener: _blocListener,
        builder: (context, state) {
          // _buildTextFieldMultiline('note', 'Note', noteController, keyboardType: TextInputType.multiline),

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Left side: Transaction List
              AppFormFields.buildTextFieldMultiline(
                  name: 'note',
                  label: 'Note to Room Guest State only',
                  enabled: true,
                   keyboardType: TextInputType.multiline,
                  controller: noteController,
                  onPressed: _onUpdateNoteButton,
                  required: false,
                  ),

              //  _buildTextFieldMultiline(
              //      'note', 'Note to Room Guest State only', noteController,
              //      keyboardType: TextInputType.multiline),
              // _buildActionButtons(),

              // Right side: Transaction Form
              Expanded(
                flex: 1,
                child: RoomGuestTransactionsManageWidget(
                    roomGuestId: widget.roomGuestId ?? 0),
              ),

              // Invoice Button
              _buildActionButtons(),
            ],
          );

          //  RoomGuestTransactionsManageWidget(roomGuestId: widget.roomGuestId ?? 0 );
        },
      ),

      //const RoomTransactionListWidget(),
    );
  }

  void _onUpdateNoteButton() {
    context
        .read<RoomGuestManageBloc>()
        .add(UpdateRoomGuestNote(widget.roomGuestId!, noteController.text));
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildButton('Invoice PDF',
            () => context.push(PdfEditPage.route(widget.roomGuestId!)))
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }

  Widget _buildTextFieldMultiline(
    String name,
    String label,
    TextEditingController controller, {
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onButtonPressed, // Callback for button press
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.save), // Add your desired button icon here
            //    onPressed: onButtonPressed ?? () {}, // Handle button action
            onPressed: _onUpdateNoteButton,
          ),
        ),
        keyboardType: keyboardType,
        maxLines: keyboardType == TextInputType.multiline ? null : 1,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }

/*
Widget _buildTextFieldMultiline(
  String name,
  String label,
  TextEditingController controller, {
  bool enabled = true,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: FormBuilderTextField(
      name: name,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      maxLines: keyboardType == TextInputType.multiline ? null : 1, // Allow multiple lines for multiline input
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
  );
}
*/

  void _blocListener(BuildContext context, RoomGuestManageState state) {
    if (state is RoomGuestManageStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is RoomGuestManageStateUpdateNoteSuccess) {
      showSnackbar(context, " Note saved ! ");
    } else if (state is RoomGuestManageStateRetrieveSuccess) {
      setState(() {
        firstName = state.roomGuest.guest!.firstName;
        lastName = state.roomGuest.guest!.lastName;
        roomNumber = state.roomGuest.roomId;
        noteController.text = state.roomGuest.note;
      });
    }
  }
}
