import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_state.dart';

class GuestDetailPage extends StatefulWidget {
  static String route([int? guestId]) => "/guests/${guestId ?? ':id'}";

  final int guestId;

  const GuestDetailPage({super.key, required this.guestId});

  @override
  State<GuestDetailPage> createState() => _GuestDetailPageState();
}

class _GuestDetailPageState extends State<GuestDetailPage> {
  @override
  void initState() {
    super.initState();

    context.read<GuestDetailBloc>().add(FetchGuestEvent(id: widget.guestId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestDetailBloc, GuestDetailState>(
      listener: (context, state) {
        if (state is GuestRetrieveStateFailure) {
            showSnackbar(context, state.message); 
          context.pop();
        }
      },
      builder: (context, state) {
        switch (state) {
          case GuestRetrieveStateInitial():
            return const SizedBox();
          case GuestRetrieveStateLoading():
           //  return Scaffold(body: Loader());
            return const Loader(); 
          case GuestRetrieveStateLoaded():
            final guest = state.guest;
            return Scaffold(
                appBar: AppBar(title: Text("Guest Title")),
                body: Column(
                  children: [
                    Text("Last Name ${guest.lastName}"),
                    Text("First Name ${guest.firstName}")
                  ],
                ));
          case GuestRetrieveStateFailure():
            return Scaffold(
                body: Center(
              child: Text(state.message),
            ));
        }
      },
    );
  }
}
