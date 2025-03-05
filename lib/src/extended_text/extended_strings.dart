import 'dart:developer' as dev;
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

extension ExtendedString on String {
  /// Capitalize the given string [s]
  /// Example : hello => Hello, WORLD => World
  String get capitalized =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();

  // String get capitalize =>
  //     split(' ').map((str) => str.capitalizeFirst).join(' ');

  /// Uppercase first letter inside string and let the others lowercase
  ///
  /// Example: your name => Your name
  String get capitalizeFirst =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String get currencyFormat =>
      NumberFormat.simpleCurrency(locale: 'EN-us').format(double.parse(this));

  String get currencyFormatWith2Precession => NumberFormat.simpleCurrency(
        locale: 'EN-us',
      ).format(double.parse(this));

  /// To load the network image
  ///
  /// Use : Image_URL.toNetworkImage
  NetworkImage get toNetworkImage => NetworkImage(this);

  /// To load the Assets image
  ///
  /// Use : Image.toAssetImage
  AssetImage get toAssetImage => AssetImage(this);

  /// To load the Cached Network image
  ///
  /// Use : Image_URL.toCachedNetworkImage
  CachedNetworkImageProvider get toCachedNetworkImage =>
      CachedNetworkImageProvider(this);

  /// To load the File image
  ///
  /// Use : Image.toFileImage
  FileImage get toFileImage => FileImage(File(this));

  void get toLog => dev.log(this);

  void get messageLog => dev.log('[Log]::', error: this);

  void get infoMessageLog => dev.log('[Info]:: $this');

  void get warningMessageLog =>
      dev.log('[Warning]::', error: this, time: DateTime.now());

  void get errorMessageLog =>
      dev.log('[Error]::', error: this, time: DateTime.now());

  void get firebaseSuccessMessageLog =>
      dev.log('[Firebase-Success]:: $this', time: DateTime.now());

  void get firebaseErrorMessageLog =>
      dev.log('[Firebase-Error]::', error: this, time: DateTime.now());

  /// Returns whether a dynamic value PROBABLY
  /// has the isEmpty getter/method by checking
  /// standard dart types that contains it.
  ///
  /// This is here to for the 'DRY'
  bool? _isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty as bool?;
    }
    return false;
  }

  /// Checks if string is a valid username.
  bool get isUsername =>
      hasMatch(this, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is Palindrom.
  bool isPalindrom(String string) {
    final cleanString = string
        .toLowerCase()
        .replaceAll(RegExp(r"\s+"), '')
        .replaceAll(RegExp(r"[^0-9a-zA-Z]+"), "");

    for (var i = 0; i < cleanString.length; i++) {
      if (cleanString[i] != cleanString[cleanString.length - i - 1]) {
        return false;
      }
    }

    return true;
  }

  /// Checks if string is Currency.
  bool get isCurrency => hasMatch(this,
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');

  /// Checks if string is phone number.
  ///
  /// This method is not perfect, it will return true if the string has 9 to 16 digits.
  ///
  /// Example:
  ///
  /// ```dart
  /// final phoneNumber = '+1 123 456 7890';
  ///
  /// phoneNumber.isPhoneNumber; // true
  bool get isPhoneNumber {
    if (length > 16 || length < 9) return false;
    return hasMatch(this, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is email.
  bool get isEmail => hasMatch(this,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Checks if string is an html file.
  bool get isHTML => toLowerCase().endsWith(".html");

  /// Checks if string is an video file.
  bool get isVideo {
    var ext = toLowerCase();

    return ext.endsWith(".mp4") ||
        ext.endsWith(".avi") ||
        ext.endsWith(".wmv") ||
        ext.endsWith(".rmvb") ||
        ext.endsWith(".mpg") ||
        ext.endsWith(".mpeg") ||
        ext.endsWith(".3gp");
  }

  /// Checks if string is an audio file.
  bool get isAudio {
    final ext = toLowerCase();

    return ext.endsWith(".mp3") ||
        ext.endsWith(".wav") ||
        ext.endsWith(".wma") ||
        ext.endsWith(".amr") ||
        ext.endsWith(".ogg");
  }

  /// Checks if string is an image file.
  bool get isImage {
    final ext = toLowerCase();

    return ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".png") ||
        ext.endsWith(".gif") ||
        ext.endsWith(".bmp");
  }

  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  // Check if the string has any number in it, not accepting double, so don't
  // use "."
  bool get isNumericOnly => hasMatch(this, r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool get isAlphabetOnly => hasMatch(this, r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool get hasCapitalletter => hasMatch(this, r'[A-Z]');

  /// Checks if data is null or blank (empty or only contains whitespace).
  bool? isBlank(dynamic value) => _isEmpty(value);

  Size get getTextSize {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this),
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  // Will add new line if the sentence is bigger the 2 words.
  /// [afterWords] will add new line after the selected word
  /// Example
  /// 'Hi, my name is'.wrapString(2)
  ///
  /// will print:
  /// Hi, my
  /// name is
  String wrapString(int afterWords) {
    final wordsArr = split(' ');

    if (wordsArr.length > 2) {
      final int middle = (indexOf(wordsArr[afterWords])) - 1;
      final prefix = substring(0, middle);
      final postfix = substring(middle + 1);
      return '$prefix\n$postfix';
    }

    return this;
  }

  bool get validateEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool equalsIgnoreCase(String? other) =>
      this == other || (other == null || toLowerCase() == other.toLowerCase());

  /// Return the string only if the delimiter exists in both ends, otherwise it will return the current string
  String? removeSurrounding(String delimiter) {
    final prefix = delimiter;
    final suffix = delimiter;

    if ((length >= prefix.length + suffix.length) &&
        startsWith(prefix) &&
        endsWith(suffix)) {
      return substring(prefix.length, length - suffix.length);
    }
    return this;
  }

  ///  Replace part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue] which defaults to the original string.
  String? replaceAfter(String delimiter, String replacement,
      [String? defaultValue]) {
    final index = indexOf(delimiter);
    return (index == -1)
        ? defaultValue!.isEmpty
            ? this
            : defaultValue
        : replaceRange(index + 1, length, replacement);
  }

  ///
  /// Replace part of string before the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue?] which defaults to the original string.
  String? replaceBefore(String delimiter, String replacement,
      [String? defaultValue]) {
    final index = indexOf(delimiter);
    return (index == -1)
        ? defaultValue!.isEmpty
            ? this
            : defaultValue
        : replaceRange(0, index, replacement);
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool Function(String element) predicate) =>
      isEmpty ? false : split('').any((s) => predicate(s));

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this;

// if the string is empty perform an action
  String? ifEmpty(Function action) => isEmpty ? action() : this;

  String get lastIndex {
    if (isEmpty) return "";
    return this[length - 1];
  }

  /// Returns a String without white space at all
  /// "hello world" // helloworld
  String? get removeAllWhiteSpace =>
      isEmpty ? null : replaceAll(RegExp(r"\s+\b|\b\s"), "");

  /// Returns a list of chars from a String
  List<String> toCharArray() => trim().isNotEmpty ? split('') : [];

  /// Returns a new string in which a specified string is inserted at a specified index position in this instance.
  String insert(int index, String str) =>
      (List<String>.from(toCharArray())..insert(index, str)).join();

  /// Indicates whether a specified string is `null`, `empty`, or consists only of `white-space` characters.
  bool get isNullOrWhiteSpace {
    var length = (split('')).where((x) => x == ' ').length;
    return length == this.length || isEmpty;
  }

  /// Shrink a string to be no more than [maxSize] in length, extending from the end.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the last 3 charachters.
  String? limitFromEnd(int maxSize) =>
      length < maxSize ? this : substring(length - maxSize);

  /// Shrink a string to be no more than [maxSize] in length, extending from the start.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the first 3 charachters.
  String? limitFromStart(int maxSize) =>
      length < maxSize ? this : substring(0, maxSize);

  /// Convert this string into boolean.
  ///
  /// Returns `true` if this string is any of these values: `"true"`, `"yes"`, `"1"`, or if the string is a number and greater than 0, `false` if less than 1. This is also case insensitive.
  bool get asBool {
    var s = trim().toLowerCase();
    num n;
    try {
      n = num.parse(s);
    } catch (e) {
      n = -1;
    }
    return s == 'true' || s == 'yes' || n > 0;
  }
}

const _defaultHeaders = {"Content-type": "application/json"};

extension HttpExtensions on String {
  /// Sends an HTTP GET request with the given headers to the given URL, which can
  /// be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.mydomain.com
  /// endpoint param - user
  /// result request -> www.mydomain.com/user

  Future<dynamic> httpGet(String endPoint) async {
    if (this.isEmpty) return;

    try {
      final response = await http.get(Uri.http(this, endPoint));
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : print('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP POST request with the given headers and body to the given URL,
  /// which can be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.mydomain.com
  /// endpoint param - user
  /// result request -> www.mydomain.com/user
  Future<dynamic> httpPost(String endPoint, String json,
      [Map<String, String> headers = _defaultHeaders]) async {
    if (this.isEmpty) return;

    try {
      final response = await http.post(Uri.http(this, endPoint),
          headers: headers, body: json);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : print('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP PUT request with the given headers and body to the given URL,
  /// which can be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.mydomain.com
  /// endpoint param - user
  /// result request -> www.mydomain.com/user
  Future<dynamic> httpPut(String endPoint, String json,
      [Map<String, String> headers = _defaultHeaders]) async {
    if (this.isEmpty) return;

    try {
      final response = await http.put(Uri.http(this, endPoint),
          headers: headers, body: json);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : 'Request failed with status: ${response.statusCode}.'.toLog;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP DELETE request with the given headers to the given URL, which
  /// can be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.mydomain.com
  /// endpoint param - user
  /// result request -> www.mydomain.com/user
  Future<dynamic> httpDelete(String endPoint,
      {Map<String, String>? headers}) async {
    if (isEmpty) return;

    try {
      final response =
          await http.delete(Uri.http(this, endPoint), headers: headers);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : 'Request failed with status: ${response.statusCode}.'.toLog;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
