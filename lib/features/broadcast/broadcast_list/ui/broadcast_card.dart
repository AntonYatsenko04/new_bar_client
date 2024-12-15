import 'package:bar_client/core_ui/src/theme/app_text_styles.dart';
import 'package:bar_client/core_ui/src/utils/date_formatter.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/core_ui/src/widgets/width_spacer.dart';
import 'package:flutter/material.dart';

class BroadcastCard extends StatelessWidget {
  final String name;
  final DateTime dateTime;
  final String description;
  final VoidCallback deleteCallback;
  final VoidCallback editCallback;

  const BroadcastCard({
    required this.name,
    required this.dateTime,
    required this.description,
    required this.deleteCallback,
    required this.editCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(name, style: AppTextStyles.s18W500H24Regular),
                      const HeightSpacer(),
                      Text(
                        DateFormatter.getDateTimeString(dateTime),
                        style: AppTextStyles.s14W400H18Regular,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const HeightSpacer(),
                      Text(description),
                      const HeightSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: deleteCallback,
                            icon: const Icon(
                              Icons.delete_forever,
                            ),
                          ),
                          const WidthSpacer(),
                          IconButton(
                            onPressed: editCallback,
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
