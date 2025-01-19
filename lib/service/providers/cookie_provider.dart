import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:bar_client/core/src/logger/logger.dart';
import 'package:encrypt/encrypt.dart';

import '../models/broadcast/broadcast_search_result_cookie_model.dart';

class CookieProvider {
  late final Key key = Key.fromUtf8(keyString);
  late final IV iv = IV(Uint8List.fromList([0, 0, 0, 0]));

  final String keyString = 't7LZkjS2t4IO7JyMkVjR/vTN5gYzukIH';

  final String _cookieName = 'broadcastSearchResultCookie';

  void updateSearchResults({
    required BroadcastSearchResultCookieModel broadcastSearchResultCookieModel,
  }) {
    _saveCookie(
      name: _cookieName + broadcastSearchResultCookieModel.token,
      value: jsonEncode(broadcastSearchResultCookieModel.toJson()),
    );
  }

  BroadcastSearchResultCookieModel? getSearchResults({required String token}) {
    try {
      final String? source = _getCookie(_cookieName + token);
      if (source == null) return null;

      final BroadcastSearchResultCookieModel broadcastSearchResultCookieModel =
          BroadcastSearchResultCookieModel.fromJson(jsonDecode(source));

      if (broadcastSearchResultCookieModel.token == token) {
        return broadcastSearchResultCookieModel;
      }
      // _clearCookies();
      return null;
    } on Exception catch (e) {
      // _clearCookies();

      return null;
    }
  }

  void _saveCookie({
    required String name,
    required String value,
  }) {
    AppLogger().debug('Initial value: $value');

    final Encrypter encrypter = Encrypter(AES(key));
    final String encryptedValue = encrypter.encrypt(value, iv: iv).base64;

    AppLogger().debug('Encrypted value: $encryptedValue');
    AppLogger().debug('Encrypted value length: ${encryptedValue.length}');

    final String encodedValue = Uri.encodeComponent(encryptedValue);

    final DateTime expirationDate = DateTime(2100);
    final String cookie =
        '$name=$encodedValue; Expires=${_formatDatetimeToRfc1123String(expirationDate.toUtc())}; Path=/';

    html.document.cookie = cookie;

    AppLogger().debug('Saved cookie: $cookie');
  }

  String? _getCookie(String name) {
    final List<String> cookies = html.document.cookie?.split('; ') ?? <String>[];
    for (final String cookie in cookies) {
      final List<String> parts = cookie.split('=');
      if (parts[0].contains(name)) {
        final String encryptedValue = parts[1];
        final String decodedValue = Uri.decodeComponent(encryptedValue);

        final Encrypter encrypter = Encrypter(AES(key));
        try {
          final String decryptedValue = encrypter.decrypt64(decodedValue, iv: iv);
          AppLogger().debug('decrypted value: $decryptedValue');
          return decryptedValue;
        } catch (e, st) {
          AppLogger().error(error: e, stackTrace: st);
          // _clearCookies();
          return null;
        }
      }
    }
    return null;
  }

  void _clearCookies({String path = '/'}) {
    final List<String> cookies = html.document.cookie?.split('; ') ?? <String>[];
    for (final String cookie in cookies) {
      final String cookieName = cookie.split('=')[0];
      html.document.cookie = '$cookieName=; Path=$path; Expires=Thu, 01 Jan 1970 00:00:00 GMT';
    }
  }

  String _formatDatetimeToRfc1123String(DateTime date) {
    const List wkday = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const List month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    DateTime d = date.toUtc();
    StringBuffer sb = StringBuffer()
      ..write(wkday[d.weekday - 1])
      ..write(', ')
      ..write(d.day <= 9 ? '0' : '')
      ..write(d.day.toString())
      ..write(' ')
      ..write(month[d.month - 1])
      ..write(' ')
      ..write(d.year.toString())
      ..write(d.hour <= 9 ? ' 0' : ' ')
      ..write(d.hour.toString())
      ..write(d.minute <= 9 ? ':0' : ':')
      ..write(d.minute.toString())
      ..write(d.second <= 9 ? ':0' : ':')
      ..write(d.second.toString())
      ..write(' GMT');
    return sb.toString();
  }
}
