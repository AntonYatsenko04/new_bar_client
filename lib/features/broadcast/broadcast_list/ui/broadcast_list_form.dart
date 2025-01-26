import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/width_spacer.dart';
import 'package:bar_client/features/broadcast/add_image/ui/add_image_screen.dart';
import 'package:bar_client/features/broadcast/bad_create_broadcast/ui/bad_create_broadcast_screen.dart';
import 'package:bar_client/features/broadcast/broadcast_list/ui/broadcast_card.dart';
import 'package:bar_client/features/broadcast/change_broadcast/ui/change_broadcast_screen.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_ui/src/widgets/error_view.dart';
import '../cubit/broadcast_list_cubit.dart';

class BroadcastListForm extends StatefulWidget {
  const BroadcastListForm({super.key});

  @override
  State<BroadcastListForm> createState() => _BroadcastListFormState();
}

class _BroadcastListFormState extends State<BroadcastListForm> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  Widget build(BuildContext context) {
    final BroadcastListCubit cubit = context.read<BroadcastListCubit>();

    return AppScaffold(
      title: LocaleKeys.broadcast_broadcastList.tr(),
      leading: Row(
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => const AddImageScreen(),
              );
              await cubit.getBroadcasts();
            },
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (_) {
                return const BadCreateBroadcastScreen();
              },
            );
            await cubit.getBroadcasts();
          },
          icon: const Icon(Icons.dangerous_outlined),
        ),
        const WidthSpacer(),
        IconButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (_) {
                return const ChangeBroadcastScreen();
              },
            );
            await cubit.getBroadcasts();
          },
          icon: const Icon(Icons.add),
        ),
        const WidthSpacer(),
        BlocBuilder<BroadcastListCubit, BroadcastListState>(
          builder: (_, BroadcastListState state) {
            return SearchAnchor(
              searchController: _searchController,
              builder: (_, SearchController controller) {
                return SizedBox(
                  width: 350,
                  child: SearchBar(
                    onTap: controller.openView,
                    controller: controller,
                    leading: IconButton(
                      onPressed: () {
                        _searchController.text = '';
                        cubit.searchBroadcasts(_searchController.text);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    trailing: <Widget>[
                      IconButton(
                        onPressed: () {
                          cubit.searchBroadcasts(_searchController.text);
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      )
                    ],
                  ),
                );
              },
              suggestionsBuilder: (_, __) {
                if (state is DataState) {
                  return state.searchSuggestions.map(
                    (String e) => ListTile(
                      title: Text(e),
                      onTap: () {
                        _searchController.closeView(e);
                        cubit.searchBroadcasts(_searchController.text);
                      },
                    ),
                  );
                }
                return <Widget>[];
              },
            );
          },
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: cubit.logout,
        child: Text(LocaleKeys.auth_logout.tr()),
      ),
      child: BlocBuilder<BroadcastListCubit, BroadcastListState>(
        builder: (BuildContext context, BroadcastListState state) {
          switch (state) {
            case DataState():
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: state.currentBroadcasts.length,
                itemBuilder: (BuildContext context, int index) {
                  final BroadcastModelResponse broadcast = state.currentBroadcasts[index];

                  return BroadcastCard(
                    name: broadcast.name,
                    dateTime: broadcast.dateTime,
                    description: broadcast.description,
                    image: state.getBroadcastImage(broadcast.id),
                    deleteCallback: () => cubit.deleteBroadcast(broadcast.id),
                    editCallback: () async {
                      await showDialog(
                        context: context,
                        builder: (_) {
                          return ChangeBroadcastScreen(
                            broadcastModelResponse: broadcast,
                          );
                        },
                      );
                      await cubit.getBroadcasts();
                    },
                  );
                },
              );
            case ErrorState():
              return Center(child: ErrorView(message: state.errorMessage.tr()));
            case LoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
