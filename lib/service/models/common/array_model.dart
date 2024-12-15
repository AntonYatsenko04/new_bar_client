class ArrayModel<T> {
  final List<T> array;

  ArrayModel({
    required this.array,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'items': this.array,
    };
  }

  factory ArrayModel.fromJson(Map<String, dynamic> map) {
    return ArrayModel<T>(
      array: map['items'] as List<T>,
    );
  }

  @override
  String toString() {
    return 'ArrayModel{array: $array}';
  }
}
