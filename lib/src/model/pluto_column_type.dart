import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

abstract class PlutoColumnType {
  dynamic get defaultValue;

  /// Set as a string column.
  factory PlutoColumnType.text({
    dynamic defaultValue = '',
  }) {
    return PlutoColumnTypeText(
      defaultValue: defaultValue,
    );
  }

  /// Set as a boolean column.
  factory PlutoColumnType.boolean({
    dynamic defaultValue = false,
  }) {
    return PlutoColumnTypeBoolean(
      defaultValue: defaultValue,
    );
  }

  /// Set to numeric column.
  ///
  /// [format]
  /// '#,###' (Comma every three digits)
  /// '#,###.###' (Allow three decimal places)
  ///
  /// [negative] Allow negative numbers
  ///
  /// [applyFormatOnInit] When the editor loads, it resets the value to [format].
  ///
  /// [allowFirstDot] When accepting negative numbers, a dot is allowed at the beginning.
  /// This option is required on devices where the .- symbol works with one button.
  ///
  /// [locale] Specifies the numeric locale of the column.
  /// If not specified, the default locale is used.
  factory PlutoColumnType.number({
    dynamic defaultValue = 0,
    bool negative = true,
    String format = '#,###.#######',
    bool applyFormatOnInit = true,
    bool allowFirstDot = false,
    String? locale,
  }) {
    return PlutoColumnTypeNumber(
      defaultValue: defaultValue,
      format: format,
      negative: negative,
      applyFormatOnInit: applyFormatOnInit,
      allowFirstDot: allowFirstDot,
      locale: locale,
    );
  }
  factory PlutoColumnType.duration({
    dynamic defaultValue = 0.0,
  }) {
    return PlutoColumnTypeDuration(
      defaultValue: defaultValue,
    );
  }

//this sorting is custom build for sorting double
  factory PlutoColumnType.double({
    dynamic defaultValue = 0.0,
    bool negative = true,
    String format = '#,###.#######',
    bool applyFormatOnInit = true,
    bool allowFirstDot = false,
    String? locale,
  }) {
    return PlutoColumnTypeDouble(
      defaultValue: defaultValue,
      format: format,
      negative: negative,
      applyFormatOnInit: applyFormatOnInit,
      allowFirstDot: allowFirstDot,
      locale: locale,
    );
  }

  /// Set to currency column.
  ///
  /// [format]
  /// '#,###' (Comma every three digits)
  /// '#,###.###' (Allow three decimal places)
  ///
  /// [negative] Allow negative numbers
  ///
  /// [applyFormatOnInit] When the editor loads, it resets the value to [format].
  ///
  /// [allowFirstDot] When accepting negative numbers, a dot is allowed at the beginning.
  /// This option is required on devices where the .- symbol works with one button.
  ///
  /// [locale] Specifies the currency locale of the column.
  /// If not specified, the default locale is used.
  factory PlutoColumnType.currency({
    dynamic defaultValue = 0,
    bool negative = true,
    String? format,
    bool applyFormatOnInit = true,
    bool allowFirstDot = false,
    String? locale,
    String? name,
    String? symbol,
    int? decimalDigits,
  }) {
    return PlutoColumnTypeCurrency(
      defaultValue: defaultValue,
      format: format,
      negative: negative,
      applyFormatOnInit: applyFormatOnInit,
      allowFirstDot: allowFirstDot,
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
  }

  /// Provides a selection list and sets it as a selection column.
  ///
  /// If [enableColumnFilter] is true, column filtering is enabled in the selection popup.
  ///
  /// Set the suffixIcon in the [popupIcon] cell. Tapping this icon will open a selection popup.
  /// The default icon is displayed, and if this value is set to null , the icon does not appear.
  factory PlutoColumnType.select(
    List<dynamic> items, {
    dynamic defaultValue = '',
    bool enableColumnFilter = false,
    IconData? popupIcon = Icons.arrow_drop_down,
  }) {
    return PlutoColumnTypeSelect(
      defaultValue: defaultValue,
      items: items,
      enableColumnFilter: enableColumnFilter,
      popupIcon: popupIcon,
    );
  }

  /// Set as a date column.
  ///
  /// [startDate] Range start date (If there is no value, Can select the date without limit)
  ///
  /// [endDate] Range end date
  ///
  /// [format] 'yyyy-MM-dd' (2020-01-01)
  ///
  /// [headerFormat] 'yyyy-MM' (2020-01)
  /// Display year and month in header in date picker popup.
  ///
  /// [applyFormatOnInit] When the editor loads, it resets the value to [format].
  ///
  /// Set the suffixIcon in the [popupIcon] cell. Tap this icon to open the date selection popup.
  /// The default icon is displayed, and if this value is set to null , the icon does not appear.
  factory PlutoColumnType.date({
    dynamic defaultValue = '',
    DateTime? startDate,
    DateTime? endDate,
    String format = 'yyyy-MM-dd',
    String headerFormat = 'yyyy-MM',
    bool applyFormatOnInit = true,
    IconData? popupIcon = Icons.date_range,
  }) {
    return PlutoColumnTypeDate(
      defaultValue: defaultValue,
      startDate: startDate,
      endDate: endDate,
      format: format,
      headerFormat: headerFormat,
      applyFormatOnInit: applyFormatOnInit,
      popupIcon: popupIcon,
    );
  }

  /// A column for the time type.
  ///
  /// Set the suffixIcon in the [popupIcon] cell. Tap this icon to open the time selection popup.
  /// The default icon is displayed, and if this value is set to null , the icon does not appear.
  factory PlutoColumnType.time({
    dynamic defaultValue = '00:00',
    IconData? popupIcon = Icons.access_time,
  }) {
    return PlutoColumnTypeTime(
      defaultValue: defaultValue,
      popupIcon: popupIcon,
    );
  }

  bool isValid(dynamic value);

  int compare(dynamic a, dynamic b);

  dynamic makeCompareValue(dynamic v);
}

extension PlutoColumnTypeExtension on PlutoColumnType {
  bool get isText => this is PlutoColumnTypeText;

  bool get isNumber => this is PlutoColumnTypeNumber;

  bool get isCurrency => this is PlutoColumnTypeCurrency;

  bool get isSelect => this is PlutoColumnTypeSelect;

  bool get isDate => this is PlutoColumnTypeDate;

  bool get isTime => this is PlutoColumnTypeTime;

  PlutoColumnTypeText get text {
    if (this is! PlutoColumnTypeText) {
      throw TypeError();
    }

    return this as PlutoColumnTypeText;
  }

  PlutoColumnTypeNumber get number {
    if (this is! PlutoColumnTypeNumber) {
      throw TypeError();
    }

    return this as PlutoColumnTypeNumber;
  }

  PlutoColumnTypeCurrency get currency {
    if (this is! PlutoColumnTypeCurrency) {
      throw TypeError();
    }

    return this as PlutoColumnTypeCurrency;
  }

  PlutoColumnTypeSelect get select {
    if (this is! PlutoColumnTypeSelect) {
      throw TypeError();
    }

    return this as PlutoColumnTypeSelect;
  }

  PlutoColumnTypeDate get date {
    if (this is! PlutoColumnTypeDate) {
      throw TypeError();
    }

    return this as PlutoColumnTypeDate;
  }

  PlutoColumnTypeTime get time {
    if (this is! PlutoColumnTypeTime) {
      throw TypeError();
    }

    return this as PlutoColumnTypeTime;
  }

  bool get hasFormat => this is PlutoColumnTypeHasFormat;

  bool get applyFormatOnInit => hasFormat ? (this as PlutoColumnTypeHasFormat).applyFormatOnInit : false;

  dynamic applyFormat(dynamic value) => hasFormat ? (this as PlutoColumnTypeHasFormat).applyFormat(value) : value;
}

class PlutoColumnTypeDuration implements PlutoColumnType {
  @override
  final dynamic defaultValue;

  const PlutoColumnTypeDuration({
    this.defaultValue,
  });

  @override
  bool isValid(dynamic value) {
    return value is String || value is num;
  }

  @override
  int compare(dynamic a, dynamic b) {
    if (a is num && b is num) {
      return a.compareTo(b);
    } else if (a is num) {
      return 1; // a is considered greater
    } else if (b is num) {
      return -1; // b is considered greater
    } else {
      // If both are strings containing both numbers and alphabets,
      // extract the numeric part for comparison
      final num aNum = _extractNumber(a);
      final num bNum = _extractNumber(b);
      return aNum.compareTo(bNum);
    }
  }

  num _extractNumber(dynamic value) {
    final RegExp regex = RegExp(r'\d+');
    final Iterable<Match> matches = regex.allMatches(value.toString());
    if (matches.isNotEmpty) {
      return num.parse(matches.first.group(0)!);
    } else {
      return defaultValue;
    }
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    return v;
  }
}

class PlutoColumnTypeBoolean implements PlutoColumnType {
  @override
  final dynamic defaultValue;

  const PlutoColumnTypeBoolean({
    this.defaultValue,
  });

  @override
  bool isValid(dynamic value) {
    return value is bool;
  }

  @override
  int compare(dynamic a, dynamic b) {
    bool boolA = a == null ? false : a as bool;
    bool boolB = b == null ? false : b as bool;

    // Custom sorting for booleans: false first, then true
    return boolA == boolB ? 0 : (boolA ? 1 : -1);
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    return v == null ? false : v as bool;
  }
}

class PlutoColumnTypeText implements PlutoColumnType {
  @override
  final dynamic defaultValue;

  const PlutoColumnTypeText({
    this.defaultValue,
  });

  @override
  bool isValid(dynamic value) {
    return value is String || value is num;
  }

  @override
  int compare(dynamic a, dynamic b) {
    return _compareWithNull(a, b, () => a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    return v.toString().toLowerCase();
  }
}

class PlutoColumnTypeDouble with PlutoColumnTypeWithDoubleFormat implements PlutoColumnType, PlutoColumnTypeHasFormat<String> {
  @override
  final dynamic defaultValue;

  @override
  final bool negative;

  @override
  final String format;

  @override
  final bool applyFormatOnInit;

  @override
  final bool allowFirstDot;

  @override
  final String? locale;

  PlutoColumnTypeDouble({
    this.defaultValue,
    required this.negative,
    required this.format,
    required this.applyFormatOnInit,
    required this.allowFirstDot,
    required this.locale,
  })  : numberFormat = intl.NumberFormat(format, locale),
        decimalPoint = _getDecimalPoint(format);

  @override
  final intl.NumberFormat numberFormat;

  @override
  final int decimalPoint;

  static int _getDecimalPoint(String format) {
    final int dotIndex = format.indexOf('.');

    return dotIndex < 0 ? 0 : format.substring(dotIndex).length - 1;
  }
}

class PlutoColumnTypeNumber with PlutoColumnTypeWithNumberFormat implements PlutoColumnType, PlutoColumnTypeHasFormat<String> {
  @override
  final dynamic defaultValue;

  @override
  final bool negative;

  @override
  final String format;

  @override
  final bool applyFormatOnInit;

  @override
  final bool allowFirstDot;

  @override
  final String? locale;

  PlutoColumnTypeNumber({
    this.defaultValue,
    required this.negative,
    required this.format,
    required this.applyFormatOnInit,
    required this.allowFirstDot,
    required this.locale,
  })  : numberFormat = intl.NumberFormat(format, locale),
        decimalPoint = _getDecimalPoint(format);

  @override
  final intl.NumberFormat numberFormat;

  @override
  final int decimalPoint;

  static int _getDecimalPoint(String format) {
    final int dotIndex = format.indexOf('.');

    return dotIndex < 0 ? 0 : format.substring(dotIndex).length - 1;
  }
}

class PlutoColumnTypeCurrency with PlutoColumnTypeWithNumberFormat implements PlutoColumnType, PlutoColumnTypeHasFormat<String?> {
  @override
  final dynamic defaultValue;

  @override
  final bool negative;

  @override
  final bool applyFormatOnInit;

  @override
  final bool allowFirstDot;

  @override
  final String? format;

  @override
  final String? locale;

  final String? name;

  final String? symbol;

  PlutoColumnTypeCurrency({
    this.defaultValue,
    required this.negative,
    required this.format,
    required this.applyFormatOnInit,
    required this.allowFirstDot,
    required this.locale,
    this.name,
    this.symbol,
    int? decimalDigits,
  }) : numberFormat = intl.NumberFormat.currency(
          locale: locale,
          name: name,
          symbol: symbol,
          decimalDigits: decimalDigits,
          customPattern: format,
        ) {
    decimalPoint = numberFormat.decimalDigits ?? 0;
  }

  @override
  final intl.NumberFormat numberFormat;

  @override
  late final int decimalPoint;
}

class PlutoColumnTypeSelect implements PlutoColumnType, PlutoColumnTypeHasPopupIcon {
  @override
  final dynamic defaultValue;

  final List<dynamic> items;

  final bool enableColumnFilter;

  @override
  final IconData? popupIcon;

  const PlutoColumnTypeSelect({
    this.defaultValue,
    required this.items,
    required this.enableColumnFilter,
    this.popupIcon,
  });

  @override
  bool isValid(dynamic value) => items.contains(value) == true;

  @override
  int compare(dynamic a, dynamic b) {
    return _compareWithNull(a, b, () {
      return items.indexOf(a).compareTo(items.indexOf(b));
    });
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    return v;
  }
}

class PlutoColumnTypeDate implements PlutoColumnType, PlutoColumnTypeHasFormat<String>, PlutoColumnTypeHasDateFormat, PlutoColumnTypeHasPopupIcon {
  @override
  final dynamic defaultValue;

  final DateTime? startDate;

  final DateTime? endDate;

  @override
  final String format;

  @override
  final String headerFormat;

  @override
  final bool applyFormatOnInit;

  @override
  final IconData? popupIcon;

  PlutoColumnTypeDate({
    this.defaultValue,
    this.startDate,
    this.endDate,
    required this.format,
    required this.headerFormat,
    required this.applyFormatOnInit,
    this.popupIcon,
  })  : dateFormat = intl.DateFormat(format),
        headerDateFormat = intl.DateFormat(headerFormat);

  @override
  final intl.DateFormat dateFormat;

  @override
  final intl.DateFormat headerDateFormat;

  @override
  bool isValid(dynamic value) {
    final parsedDate = DateTime.tryParse(value.toString());

    if (parsedDate == null) {
      return false;
    }

    if (startDate != null && parsedDate.isBefore(startDate!)) {
      return false;
    }

    if (endDate != null && parsedDate.isAfter(endDate!)) {
      return false;
    }

    return true;
  }

  @override
  int compare(dynamic a, dynamic b) {
    return _compareWithNull(a, b, () => a.toString().compareTo(b.toString()));
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    DateTime? dateFormatValue;

    try {
      dateFormatValue = dateFormat.parse(v.toString());
    } catch (e) {
      dateFormatValue = null;
    }

    return dateFormatValue;
  }

  @override
  String applyFormat(dynamic value) {
    final parseValue = DateTime.tryParse(value.toString());

    if (parseValue == null) {
      return '';
    }

    return dateFormat.format(DateTime.parse(value.toString()));
  }
}

class PlutoColumnTypeTime implements PlutoColumnType, PlutoColumnTypeHasPopupIcon {
  @override
  final dynamic defaultValue;

  @override
  final IconData? popupIcon;

  const PlutoColumnTypeTime({
    this.defaultValue,
    this.popupIcon,
  });

  static final _timeFormat = RegExp(r'^([0-1]?\d|2[0-3]):[0-5]\d$');

  @override
  bool isValid(dynamic value) {
    return _timeFormat.hasMatch(value.toString());
  }

  @override
  int compare(dynamic a, dynamic b) {
    return _compareWithNull(a, b, () => a.toString().compareTo(b.toString()));
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    return v;
  }
}

abstract class PlutoColumnTypeHasFormat<T> {
  const PlutoColumnTypeHasFormat({
    required this.format,
    required this.applyFormatOnInit,
  });

  final T format;

  final bool applyFormatOnInit;

  dynamic applyFormat(dynamic value);
}

abstract class PlutoColumnTypeHasDateFormat {
  const PlutoColumnTypeHasDateFormat({
    required this.dateFormat,
    required this.headerFormat,
    required this.headerDateFormat,
  });

  final intl.DateFormat dateFormat;

  final String headerFormat;

  final intl.DateFormat headerDateFormat;
}

abstract class PlutoColumnTypeHasPopupIcon {
  IconData? get popupIcon;
}

mixin PlutoColumnTypeWithDoubleFormat {
  intl.NumberFormat get numberFormat;

  bool get negative;

  int get decimalPoint;

  bool get allowFirstDot;

  String? get locale;

  bool isValid(dynamic value) {
    if (!isNumeric(value)) {
      return false;
    }

    if (negative == false && num.parse(value.toString()) < 0) {
      return false;
    }

    return true;
  }

  int compare(dynamic a, dynamic b) {
    return _compareWithNull(
      a,
      b,
      () => toDouble(a.toString()).compareTo(toDouble(b.toString())),
    );
  }

  dynamic makeCompareValue(dynamic v) {
    return v.runtimeType != num ? toDouble(v.toString()) : v;
  }

  String applyFormat(dynamic value) {
    double number = toDouble(value.toString());

    if (negative == false && number < 0) {
      number = 0.0;
    }

    return numberFormat.format(number);
  }

  /// Convert [String] converted to [applyFormat] to [double].
  double toDouble(String formatted) {
    String match = '0-9\\-${numberFormat.symbols.DECIMAL_SEP}';

    if (negative) {
      match += numberFormat.symbols.MINUS_SIGN;
    }

    formatted = formatted.replaceAll(RegExp('[^$match]'), '').replaceFirst(numberFormat.symbols.DECIMAL_SEP, '.');

    final double formattedDouble = double.tryParse(formatted) ?? 0.0;

    return formattedDouble.isFinite ? formattedDouble : 0.0;
  }

  bool isNumeric(dynamic s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s.toString()) != null;
  }
}

mixin PlutoColumnTypeWithNumberFormat {
  intl.NumberFormat get numberFormat;

  bool get negative;

  int get decimalPoint;

  bool get allowFirstDot;

  String? get locale;

  bool isValid(dynamic value) {
    if (!isNumeric(value)) {
      return false;
    }

    if (negative == false && num.parse(value.toString()) < 0) {
      return false;
    }

    return true;
  }

  int compare(dynamic a, dynamic b) {
    return _compareWithNull(
      a,
      b,
      () => toNumber(a.toString()).compareTo(toNumber(b.toString())),
    );
  }

  dynamic makeCompareValue(dynamic v) {
    return v.runtimeType != num ? num.tryParse(v.toString()) ?? 0 : v;
  }

  String applyFormat(dynamic value) {
    num number = num.tryParse(
          value.toString().replaceAll(numberFormat.symbols.DECIMAL_SEP, '.'),
        ) ??
        0;

    if (negative == false && number < 0) {
      number = 0;
    }

    return numberFormat.format(number);
  }

  /// Convert [String] converted to [applyFormat] to [number].
  dynamic toNumber(String formatted) {
    String match = '0-9\\-${numberFormat.symbols.DECIMAL_SEP}';

    if (negative) {
      match += numberFormat.symbols.MINUS_SIGN;
    }

    formatted = formatted.replaceAll(RegExp('[^$match]'), '').replaceFirst(numberFormat.symbols.DECIMAL_SEP, '.');

    final num formattedNumber = num.tryParse(formatted) ?? 0;

    return formattedNumber.isFinite ? formattedNumber : 0;
  }

  bool isNumeric(dynamic s) {
    if (s == null) {
      return false;
    }
    return num.tryParse(s.toString()) != null;
  }
}

int _compareWithNull(
  dynamic a,
  dynamic b,
  int Function() resolve,
) {
  if (a == null || b == null) {
    return a == b
        ? 0
        : a == null
            ? -1
            : 1;
  }

  return resolve();
}
