import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_state.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';

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

    context
        .read<GuestDetailBloc>()
        .add(FetchGuestRetrieveEvent(id: widget.guestId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestDetailBloc, GuestDetailState>(
      listener: (context, state) {
        if (state is GuestDetailStateFailure) {
          showSnackbar(context, state.message);
          context.pop();
        }
      },
      builder: (context, state) {
        switch (state) {
          case GuestDetailtateInitial():
            return const SizedBox();
          case GuestDetailStateLoading():
            //  return Scaffold(body: Loader());
            return const Loader();
          case GuestDetailStateLoaded():
            final guest = state.guest;
            return Scaffold(
                appBar: AppBar(
                  title: Text("Guest Title"),
                  actions: [
                    IconButton(onPressed: () {
                       context.push(GuestEditPage.route(state.guest.id));   
                    }, icon: const Icon( Icons.edit)),
                  ],
                ),
                body: Column(
                  children: [
                    Text("Last Name ${guest.lastName}"),
                    Text("First Name ${guest.firstName}")
                  ],
                ));
          case GuestDetailStateFailure():
            return Scaffold(
                body: Center(
              child: Text(state.message),
            ));
        }
      },
    );
  }
}
