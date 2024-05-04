
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_state.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_detail_page.dart';

class GuestListWidgets extends StatefulWidget {
  const GuestListWidgets({super.key});

  @override
  State<GuestListWidgets> createState() => _GuestListWidgetsState();
}

class _GuestListWidgetsState extends State<GuestListWidgets> {
  @override
  void initState() {
    super.initState();

    context.read<GuestListBloc>().add(FetchGuestsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestListBloc, GuestListState>(
      builder: (context, state) {
        switch (state) {
          case GuestListStateInitial():
           
            return const SizedBox.shrink();
          case GuestListStateLoading():
            return const Loader();
      
          case GuestListStateLoaded():
            final guests = state.guests;
            return ListView.builder(
              itemCount: guests.length,
              itemBuilder: (context, index) {
                final guest = guests[index];
                return Card(
                  child: ListTile(title: Text(guest.email),  
                  subtitle: Text("Name ${guest.id}"),
                   onTap: () {
                    context.push(GuestDetailPage.route(guest.id));
                  },
                  
                  
                  ),
                  
  
                );
              },
            );
          case GuestListStateFailure():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
