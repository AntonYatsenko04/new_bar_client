part of 'bad_create_broadcast_cubit.dart';

class BadCreateBroadcastState {
  final DateTime dateTime;
  final String? commonError;

  BadCreateBroadcastState({
    required this.dateTime,
    this.commonError,
  });

  String get dateTimeString => DateFormatter.getDateTimeString(dateTime);

  BadCreateBroadcastState copyWith({
    DateTime? dateTime,
    String? commonError,
  }) {
    return BadCreateBroadcastState(
      dateTime: dateTime ?? this.dateTime,
      commonError: commonError ?? this.commonError,
    );
  }
}
