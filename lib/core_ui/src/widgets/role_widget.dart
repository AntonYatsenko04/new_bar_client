import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/service/models/auth/user_model.dart';
import 'package:bar_client/service/services/user_service.dart';
import 'package:flutter/material.dart';

class RoleWidget extends StatefulWidget {
  final Widget child;
  final List<UserType> allowedRoles;

  const RoleWidget({
    required this.child,
    required this.allowedRoles,
    super.key,
  });

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  bool showWidget = false;

  @override
  void initState() {
    super.initState();
    appLocator<UserService>().getCurrentUserInfo().then((UserModel info) {
      if (widget.allowedRoles.contains(info.userType)) {
        setState(() {
          showWidget = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (showWidget) {
      true => widget.child,
      false => const SizedBox.shrink(),
    };
  }
}
