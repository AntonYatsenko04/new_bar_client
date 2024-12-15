part of 'change_broadcast_cubit.dart';

class ChangeBroadcastState {
  final DateTime dateTime;
  final String? nameError;
  final String? descriptionError;
  final String? commonError;

  ChangeBroadcastState({
    required this.dateTime,
    this.nameError,
    this.descriptionError,
    this.commonError,
  });
  String get dateTimeString => DateFormatter.getDateTimeString(dateTime);

  ChangeBroadcastState copyWith({
    DateTime? dateTime,
    String? nameError,
    String? descriptionError,
    String? commonError,
  }) {
    return ChangeBroadcastState(
      dateTime: dateTime ?? this.dateTime,
      nameError: nameError ?? this.nameError,
      descriptionError: descriptionError ?? this.descriptionError,
      commonError: commonError ?? this.commonError,
    );
  }
}
