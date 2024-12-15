import 'package:bar_client/core_ui/src/widgets/menu_card.dart';
import 'package:bar_client/core_ui/src/widgets/width_spacer.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:flutter/material.dart';

class ListMenuCard extends StatelessWidget {
  final MenuItemResponse menuItemModel;
  final VoidCallback deleteCallback;
  final VoidCallback editCallback;

  const ListMenuCard({
    required this.menuItemModel,
    required this.deleteCallback,
    required this.editCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuCard(
      menuItemModel: menuItemModel,
      actions: <Widget>[
        IconButton(
          onPressed: deleteCallback,
          icon: const Icon(Icons.delete_forever),
        ),
        const WidthSpacer(),
        IconButton(
          onPressed: editCallback,
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
