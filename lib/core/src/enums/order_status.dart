import 'package:json_annotation/json_annotation.dart';

import '../localization/generated/locale_keys.g.dart';

@JsonEnum(valueField: 'apiCode')
enum OrderStatus {
  taken(
    apiCode: 'taken',
    localeKey: LocaleKeys.order_orderStatuses_taken,
  ),
  inCooking(
    apiCode: 'inCooking',
    localeKey: LocaleKeys.order_orderStatuses_inCooking,
  ),
  pendingPayment(
    apiCode: 'pendingPayment',
    localeKey: LocaleKeys.order_orderStatuses_pendingPayment,
  ),
  complete(
    apiCode: 'complete',
    localeKey: LocaleKeys.order_orderStatuses_complete,
  );

  final String apiCode;
  final String localeKey;

  const OrderStatus({
    required this.apiCode,
    required this.localeKey,
  });

  static OrderStatus statusByApiCode(String apiCode) {
    return OrderStatus.values.firstWhere((OrderStatus status) => status.apiCode == apiCode);
  }

  OrderStatus? get nextIfExists {
    switch (this) {
      case OrderStatus.taken:
        return OrderStatus.inCooking;
      case OrderStatus.inCooking:
        return OrderStatus.pendingPayment;
      case OrderStatus.pendingPayment:
        return OrderStatus.complete;
      case OrderStatus.complete:
        return null;
    }
  }

  bool isVisibleForCook() {
    return this == OrderStatus.taken || this == OrderStatus.inCooking;
  }
}
