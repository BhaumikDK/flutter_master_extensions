import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'gesture/gesture_transform.dart';
import 'size_utils/custom_simmer.dart';
import 'error_handling/range_exceptions.dart';

extension ExtendedDouble on double {
  SizedBox get toVSB => SizedBox(height: this);

  SizedBox get toHSB => SizedBox(width: this);

  Radius get toRadius => Radius.circular(this);

  BorderRadius get toAllRadius => BorderRadius.all(toRadius);

  BorderRadius get toAllBorderRadius => BorderRadius.circular(this);

  EdgeInsets get toPadding => EdgeInsets.all(this);

  EdgeInsets get toSymmetricPaddingHR => EdgeInsets.symmetric(horizontal: this);

  EdgeInsets get toSymmetricPaddingVR => EdgeInsets.symmetric(vertical: this);

  EdgeInsets get toPaddingOnlyBottom => EdgeInsets.only(bottom: this);

  EdgeInsets get toPaddingOnlyLeft => EdgeInsets.only(left: this);

  EdgeInsets get toPaddingOnlyRight => EdgeInsets.only(right: this);

  EdgeInsets get toPaddingOnlyTop => EdgeInsets.only(top: this);
}

extension ExtendedInteger on int {
  /// Return the min if this number is smaller then minimum
  /// Return the max if this number is bigger the the maximum
  /// Return this number if it's between the range
  int inRangeOf(int min, int max) {
    if (min.isNull || max.isNull) throw Exception('min or max cannot be null');
    if (min > max) throw ArgumentError('min must be smaller the max');

    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  // ignore: unnecessary_null_comparison
  bool get isNull => (this == null);

  /// Returns the absolute value
  get absolute => abs();

  /// Returns number of digits in this number
  int get numberOfDigits => toString().length;

  /// Returns if the number is even
  bool get isEven => this % 2 == 0;

  /// Returns if the number is odd
  bool get isOdd => this % 2 != 0;

  /// Returns if the number is positive
  bool get isPositive => this > 0;

  /// Returns if the number is negative
  bool get isNegative => this < 0;

  /// Return squared number
  int get squared => this * this;

  /// Convert this integer into boolean.
  ///
  /// Returns `true` if this integer is greater than *0*.
  bool get asBool => this > 0;

  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );

  bool isEqual(num b) => this == b;

  bool isGreaterOrEqual(num b) => this >= b;

  bool isGreaterThan(num b) => this > b;

  bool isLowerOrEqual(num b) => this <= b;

  bool isLowerThan(num b) => this < b;

  /// Returns a sequence of integer, starting from [this],
  /// increments by [step] and ends at [end]
  Iterable<int> until(int end, {int step = 1}) sync* {
    if (step == 0) {
      throw ExtenedException.steps();
    }

    int currentNumber = this;

    if (step > 0) {
      while (currentNumber < end) {
        yield currentNumber;
        currentNumber += step;
      }
    } else {
      while (currentNumber > end) {
        yield currentNumber;
        currentNumber += step;
      }
    }
  }
}

extension ExtendedEasySorting on List<int> {
  List<int> quickSort([int? left, int? right]) {
    var list = this;
    if ((left ?? 0) >= (right ?? 0)) return [-1];
    int pivot = left!, i = left, j = right!, direction = -1, temp = 0;
    while (i < j) {
      if (direction == -1) {
        if (list[j] < list[pivot]) {
          temp = list[j];
          list[j] = list[pivot];
          list[pivot] = temp;
          pivot = j;
          direction = 1;
        } else {
          j--;
        }
      }
      if (direction == 1) {
        if (list[i] > list[pivot]) {
          temp = list[i];
          list[i] = list[pivot];
          list[pivot] = temp;
          pivot = i;
          direction = -1;
        } else {
          i++;
        }
      }
    }
    quickSort(left, i);
    quickSort(i + 1, right);

    return list;
  }
}

extension ExtendedMap on Map<String, dynamic> {
  /// Flatten a nested Map into a single level map
  ///
  /// If you don't want to flatten arrays (with 0, 1,... indexes),
  /// use [safe] mode.
  ///
  /// To avoid circular reference issues or huge calculations,
  /// you can specify the [maxDepth] the function will traverse.
  Map<String, dynamic> flatJson(
      {String delimiter = ".", bool safe = false, int? maxDepth}) {
    final result = <String, dynamic>{};

    void step(Map<String, dynamic> obj,
        [String? previousKey, int currentDepth = 1]) {
      obj.forEach((key, value) {
        final newKey = previousKey != null ? "$previousKey$delimiter$key" : key;

        if (maxDepth != null && currentDepth >= maxDepth) {
          result[newKey] = value;
          return;
        }
        if (value is Map<String, dynamic>) {
          return step(value, newKey, currentDepth + 1);
        }
        if (value is List && !safe) {
          return step(
            _listToMap(value as List<Object>),
            newKey,
            currentDepth + 1,
          );
        }
        result[newKey] = value;
      });
    }

    step(this);

    return result;
  }

  Map<String, T> _listToMap<T>(List<T> list) =>
      list.asMap().map((key, value) => MapEntry(key.toString(), value));
}

extension ExtendedDateTimeExtension on DateTime {
  String timeAgo({final bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String formatDate() {
    const dateFormatter = 'MMMM dd, y';
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(final DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  int get getDifferenceInDaysWithNow {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }

  /// Adds this DateTime and Duration and returns the sum as a new DateTime object.
  DateTime operator +(Duration duration) => add(duration);

  /// Subtracts the Duration from this DateTime returns the difference as a new DateTime object.
  DateTime operator -(Duration duration) => subtract(duration);

  /// Returns true if [other] is in the same year as [this].
  ///
  /// Does not account for timezones.
  bool isAtSameYearAs(DateTime other) => year == other.year;

  /// Returns true if [other] is in the same month as [this].
  ///
  /// This means the exact month, including year.
  ///
  /// Does not account for timezones.
  bool isAtSameMonthAs(DateTime other) =>
      isAtSameYearAs(other) && month == other.month;

  /// Returns true if [other] is on the same day as [this].
  ///
  /// This means the exact day, including year and month.
  ///
  /// Does not account for timezones.
  bool isAtSameDayAs(DateTime other) =>
      isAtSameMonthAs(other) && day == other.day;

  /// Returns true if [other] is at the same hour as [this].
  ///
  /// This means the exact hour, including year, month and day.
  ///
  /// Does not account for timezones.
  bool isAtSameHourAs(DateTime other) =>
      isAtSameDayAs(other) && hour == other.hour;

  /// Returns true if [other] is at the same minute as [this].
  ///
  /// This means the exact minute, including year, month, day and hour.
  ///
  /// Does not account for timezones.
  bool disAtSameMinuteAs(DateTime other) =>
      isAtSameHourAs(other) && minute == other.minute;

  /// Returns true if [other] is at the same minute as [this].
  ///
  /// This means the exact minute, including year, month, day and hour.
  ///
  /// Does not account for timezones.
  bool isAtSameMinuteAs(DateTime other) =>
      isAtSameHourAs(other) && minute == other.minute;

  /// Returns true if [other] is at the same second as [this].
  ///
  /// This means the exact second, including year, month, day, hour and minute.
  ///
  /// Does not account for timezones.
  bool isAtSameSecondAs(DateTime other) =>
      isAtSameMinuteAs(other) && second == other.second;

  /// Returns true if [other] is at the same millisecond as [this].
  ///
  /// This means the exact millisecond,
  /// including year, month, day, hour, minute and second.
  ///
  /// Does not account for timezones.
  bool isAtSameMillisecondAs(DateTime other) =>
      isAtSameSecondAs(other) && millisecond == other.millisecond;

  /// Returns true if [other] is at the same microsecond as [this].
  ///
  /// This means the exact microsecond,
  /// including year, month, day, hour, minute, second and millisecond.
  ///
  /// Does not account for timezones.
  bool isAtSameMicrosecondAs(DateTime other) =>
      isAtSameMillisecondAs(other) && microsecond == other.microsecond;

  bool get isYesterday {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day - 1;
  }

  /// The list of days in a given month
  List<DateTime> get daysInMonth {
    var first = firstDayOfMonth;
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));
    var last = lastDayOfMonth;

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    var lastToDisplay = last.add(Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  bool get isFirstDayOfMonth => isSameDay(firstDayOfMonth, this);

  bool get isLastDayOfMonth => isSameDay(lastDayOfMonth, this);

  DateTime get firstDayOfMonth => DateTime(year, month);

  DateTime get firstDayOfWeek {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(year, month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return subtract(Duration(days: decreaseNum));
  }

  DateTime get lastDayOfWeek {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final getDay = DateTime.utc(year, month, day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = getDay.weekday % 7;
    return getDay.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  DateTime get lastDayOfMonth {
    var beginningNextMonth =
        (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  DateTime get previousMonth {
    var year = this.year;
    var month = this.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  DateTime get nextMonth {
    var year = this.year;
    var month = this.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  DateTime get previousWeek => subtract(const Duration(days: 7));

  DateTime get nextWeek => add(const Duration(days: 7));

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(const Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// return true if the date is today
  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentDate = DateTime(year, month, day);
    return today.isAtSameMomentAs(currentDate);
  }

  /// to add years to a [DateTime] add a positive number
  /// to remove years pass a negative number
  DateTime addOrRemoveYears(int years) =>
      DateTime(year + years, month, day, minute, second);

  /// to add month to a [DateTime] add a positive number
  /// to remove years pass a negative number
  DateTime addOrRemoveMonth(int months) =>
      DateTime(year, month + months, day, minute, second);

  /// to add days to a [DateTime] add a positive number
  /// to remove days pass a negative number
  DateTime addOrRemoveDay(int days) =>
      DateTime(year, month, day + days, minute, second);

  /// to add min to a [DateTime] add a positive number
  /// to remove min pass a negative number
  DateTime addOrRemoveMinutes(int min) =>
      DateTime(year, month, day, minute + min, second);

  /// to add sec to a [DateTime] add a positive number
  /// to remove sec pass a negative number
  DateTime addOrRemoveSeconds(int sec) =>
      DateTime(year, month, day, minute, second + sec);

  ///  Start time of Date times
  DateTime startOfDay() => DateTime(year, month, day);

  DateTime startOfMonth() => DateTime(year, month);

  DateTime startOfYear() => DateTime(year);

  /// next day
  DateTime tomorrow() => DateTime(year, month, day + 1);

  /// last day
  DateTime yesterday() => DateTime(year, month, day - 1);

  /// return the smaller date between
  DateTime min(DateTime that) =>
      (millisecondsSinceEpoch < that.millisecondsSinceEpoch) ? this : that;

  DateTime max(DateTime that) =>
      (millisecondsSinceEpoch > that.millisecondsSinceEpoch) ? this : that;

  bool get isLeapYear =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
}

extension ExtendedWidget on Widget {
  Center get toCenter => Center(child: this);

  Expanded toExpanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Flexible toFlexible({int flex = 1}) => Flexible(flex: flex, child: this);

  Align get centerLeftAlign =>
      Align(alignment: Alignment.centerLeft, child: this);

  Align get topLeftAlign => Align(alignment: Alignment.topLeft, child: this);

  Align get bottomLeftAlign =>
      Align(alignment: Alignment.bottomLeft, child: this);

  Align get centerRightAlign =>
      Align(alignment: Alignment.centerRight, child: this);

  Align get topRightAlign => Align(alignment: Alignment.topRight, child: this);

  Align get bottomRightAlign =>
      Align(alignment: Alignment.bottomRight, child: this);

  Align get bottomCenterAlign =>
      Align(alignment: Alignment.bottomCenter, child: this);

  Align get centerAlign => Align(child: this);

  Align get topCenterAlign =>
      Align(alignment: Alignment.topCenter, child: this);

  Align get leftCenterAlign =>
      Align(alignment: Alignment.centerLeft, child: this);

  FittedBox get toFittedBox => FittedBox(child: this);

  Widget withTooltip(
    String message, {
    Decoration? decoration,
    double? height,
    bool? preferBelow,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    Duration? waitDuration,
    EdgeInsetsGeometry? margin,
  }) =>
      Tooltip(
        message: message,
        decoration: decoration,
        height: height,
        padding: padding,
        preferBelow: preferBelow,
        textStyle: textStyle,
        waitDuration: waitDuration,
        margin: margin,
        child: this,
      );

  Opacity setOpacity({required double opacity}) =>
      Opacity(opacity: opacity, child: this);

  Widget get toSliver => SliverToBoxAdapter(child: this);
}

extension ExtendedPadding on Widget {
  /// To give all sides padding
  Padding toAllPadding(final double value) =>
      Padding(padding: value.toPadding, child: this);

  /// To give horizontal padding Only
  Padding toHorizontalPadding(final double value) =>
      Padding(padding: value.toSymmetricPaddingHR, child: this);

  /// To give vertical padding Only
  Padding toVerticalPadding(final double value) => Padding(
        padding: value.toSymmetricPaddingVR,
        child: this,
      );

  /// To give view padding with device pixel ratio
  Padding fromViewPadding(final ViewPadding padding, double devicePixelRatio) =>
      Padding(
        padding: EdgeInsets.fromViewPadding(padding, devicePixelRatio),
        child: this,
      );

  Padding paddingLTRB(double left, double top, double right, double bottom) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Padding paddingSTEB(double start, double top, double end, double bottom) =>
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(start, top, end, bottom),
        child: this,
      );

  /// To give symmetric padding [horizontal] and [vertical]
  Padding toSymmetricPadding(
          {final double? horizontal, final double? vertical}) =>
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 0, vertical: vertical ?? 0),
        child: this,
      );

  /// To give padding individually [left], [right], [top], [bottom]
  Padding toOnlyPadding(
          {final double? left,
          final double? right,
          final double? top,
          final double? bottom}) =>
      Padding(
        padding: EdgeInsets.only(
            left: left ?? 0.0,
            right: right ?? 0.0,
            bottom: bottom ?? 0.0,
            top: top ?? 0.0),
        child: this,
      );
}

extension ExtendedShimmerEffect on Widget {
  Widget applyShimmer(
      {bool enable = true, Color? baseColor, Color? highlightColor}) {
    if (enable) {
      return CustomShimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: highlightColor ?? Colors.grey.shade100,
        enabled: enable,
        child: this,
      );
    } else {
      return this;
    }
  }
}

extension ContainerExtensions on Container {
  /// Add round corners to a Container
  ///  if the Container already has a color use [backgroundColor] instead and remove the
  ///  [Color] from the Container it self
  Container withRoundCorners({required Color backgroundColor}) => Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: 25.0.toAllBorderRadius,
        ),
        child: this,
      );

  /// A shadow cast by a box
  ///
  /// [shadowColor]
  Container withShadow(
          {Color shadowColor = Colors.grey,
          double blurRadius = 20.0,
          double spreadRadius = 1.0,
          Offset offset = const Offset(10.0, 10.0)}) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: offset),
          ],
        ),
        child: this,
      );
}

extension GestureDetectorExtensions on Widget {
  Widget get onTapAddJumpEffect => TranslateOnClick(child: this);

  Widget onDoubleTap(Function() function) => GestureDetector(
        onDoubleTap: function,
        child: this,
      );

  Widget onTap(Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget onLongPress(Function() function) => GestureDetector(
        onLongPress: function,
        child: this,
      );
}

extension ExtendedListExtension on List {
  ///Returns items that are not null, for UI Widgets/PopupMenuItems etc.
  List<Widget> get notNullWidget => whereType<Widget>().toList();

  /// Returns a new list of widgets with the specified separator widget inserted
  /// between each pair of widgets from the original list.
  ///
  /// The method asserts that the list is of type `List<Widget>`.
  ///
  /// Example:
  /// ```dart
  /// List<Widget> widgets = [Widget1(), Widget2(), Widget3()];
  /// Widget separator = Divider();
  /// List<Widget> separatedWidgets = widgets.separatedB y(separator);
  /// // Result: [Widget1(), Divider(), Widget2(), Divider(), Widget3()]
  /// ```
  ///
  /// - Parameter separator: The widget to insert between each pair of widgets.
  /// - Returns: A new list of widgets with the separator inserted.
  List<Widget> separatedBy(Widget separator) {
    assert(this is List<Widget>,
        'List should be a List<Widget> but is $runtimeType');
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < length; i++) {
      list.add(this[i]);
      if (i != length - 1) list.add(separator);
    }
    return list;
  }
}

extension AlignExtensions on Widget {
  Align alignAtBottomCenter({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.bottomCenter,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtTopLeft({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.topLeft,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtBottomLeft({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.bottomLeft,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtBottomRight({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.bottomRight,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtCenterLeft({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.centerLeft,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtCenter({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.center,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtCenterRight({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.centerRight,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtLERP(
    Alignment a,
    Alignment b,
    double t, {
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.lerp(a, b, t)!,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignXY(
    double x,
    double y, {
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment(x, y),
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtTopCenter({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.topCenter,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtTopRight({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: Alignment.topRight,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );
}
