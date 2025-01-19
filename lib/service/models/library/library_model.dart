import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_model.freezed.dart';
part 'library_model.g.dart';

@freezed
class LibraryModel with _$LibraryModel {
  const factory LibraryModel({
    required double time,
    required int memory,
    required List<Datum> data,
  }) = _LibraryModel;

  factory LibraryModel.fromJson(Map<String, dynamic> json) => _$LibraryModelFromJson(json);
}

@Freezed(toStringOverride: false)
class Datum with _$Datum {
  const factory Datum({
    @JsonKey(name: 'AuthorID') required int authorId,
    @JsonKey(name: 'AuthorName') required String authorName,
    @JsonKey(name: 'AuthorCountry') required String authorCountry,
    @JsonKey(name: 'BookID') required int bookId,
    @JsonKey(name: 'BookTitle') required String bookTitle,
    @JsonKey(name: 'BookGenre') required String bookGenre,
    @JsonKey(name: 'PublisherID') required int? publisherId,
    @JsonKey(name: 'PublisherName') required String? publisherName,
    @JsonKey(name: 'PublisherCountry') required String? publisherCountry,
    @JsonKey(name: 'ReviewID') required int? reviewId,
    @JsonKey(name: 'ReviewerName') required String? reviewerName,
    @JsonKey(name: 'Rating') required int? rating,
    @JsonKey(name: 'ReviewText') required String? reviewText,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

String datumToString(Datum datum) {
  return 'Книга (АвторID: ${datum.authorId}, Имя Автора: ${datum.authorName}, Страна Автора: ${datum.authorCountry}, КнигаID: ${datum.bookId}, Название Книги: ${datum.bookTitle}, Жанр Книги: ${datum.bookGenre}, ИздательID: ${datum.publisherId}, Имя Издателя: ${datum.publisherName}, Страна Издателя: ${datum.publisherCountry}, ОтзывID: ${datum.reviewId}, Имя Рецензента: ${datum.reviewerName}, Рейтинг: ${datum.rating}, Текст Отзыва: ${datum.reviewText})';
}

enum AuthorCountry { UK, USA }

final authorCountryValues = EnumValues({"UK": AuthorCountry.UK, "USA": AuthorCountry.USA});

enum BookGenre { FICTION, NON_FICTION }

final bookGenreValues =
    EnumValues({"Fiction": BookGenre.FICTION, "Non-Fiction": BookGenre.NON_FICTION});

enum PublisherCountry { FRANCE, GERMANY }

final publisherCountryValues =
    EnumValues({"France": PublisherCountry.FRANCE, "Germany": PublisherCountry.GERMANY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
