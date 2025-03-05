import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../flutter_master_extensions.dart';

extension ExtendedContext on BuildContext {
  // Returns the MediaQuery
  MediaQueryData get mq => MediaQuery.of(this);

  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  /// performs a simple [Theme.of(context).size] action and returns given [height or width]
  double get deviceHeight => mediaQuerySize.height;

  // The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get deviceWidth => mediaQuerySize.width;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// The same of MediaQuery.sizeOf(context)
  Size get mqSize => MediaQuery.sizeOf(this);

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  /// performs a simple [Theme.of(context).size] action and returns given [height or width]
  double screenHeight([final double percent = 1]) => sizePx.height * percent;

  double screenWidth([final double percent = 1]) => sizePx.width * percent;

  bool get alwaysUse24HourFormat => mq.alwaysUse24HourFormat;

  /// similar to [MediaQuery.of(this).devicePixelRatio]
  double get devicePixelRatio => mq.devicePixelRatio;

  /// check if device is on landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => sizePx.shortestSide;

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  /// True if the shortestSide is smaller than 600p
  bool get isPhone => (mediaQueryShortestSide < 600);

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// similar to [MediaQuery.of(context).padding]
  EdgeInsets get mediaQueryPadding => mq.padding;

  /// similar to [MediaQuery.of(context).viewInsets]
  EdgeInsets get mediaQueryViewInsets => mq.viewInsets;

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryViewPadding => mq.viewPadding;

  /// similar to [MediaQuery.alwaysUse24HourFormatOf(context)]
  bool get mqAlwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);

  /// similar to [MediaQuery.devicePixelRatioOf(context)]
  double get mqDevicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// similar to [MediaQuery.orientationOf(context)]
  Orientation get mqOrientation => MediaQuery.orientationOf(this);

  /// similar to [ MediaQuery.paddingOf(context)]
  EdgeInsets get mqPadding => MediaQuery.paddingOf(this);

  /// similar to [MediaQuery.platformBrightnessOf(context)]
  Brightness get mqPlatformBrightness => MediaQuery.platformBrightnessOf(this);

  /// similar to [MediaQuery.textScaleFactorOf(context)]
  TextScaler get mqTextScaleFactor => MediaQuery.textScalerOf(this);

  /// similar to [MediaQuery.viewInsetsOf(context)]
  EdgeInsets get mqViewInsets => MediaQuery.viewInsetsOf(this);

  /// similar to [MediaQuery.viewPaddingOf(context)]
  EdgeInsets get mqViewPadding => MediaQuery.viewPaddingOf(this);

  /// The same of MediaQuery.sizeOf(context).height
  double get mqHeight => mqSize.height;

  /// The same of [MediaQuery.sizeOf(context).width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get mqWidth => mqSize.width;

  /// similar to [MediaQuery.of(context).orientation]
  Orientation get orientation => mq.orientation;

  Brightness get platformBrightness => mq.platformBrightness;

  /// True if width be larger than 800
  bool get showNavbar => (width > 800);

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get width => sizePx.width;

  /// Returns a specific value according to the screen size
  /// if the device width is higher than or equal to 1200 return
  /// [desktop] value. if the device width is higher than  or equal to 600
  /// and less than 1200 return [tablet] value.
  /// if the device width is less than 300  return [watch] value.
  /// in other cases return [mobile] value.
  T? responsiveValue<T>({T? mobile, T? tablet, T? desktop}) {
    var deviceWidth = mediaQuerySize.shortestSide;
    if (MyPlatform.isDesktop) {
      deviceWidth = mediaQuerySize.width;
    }
    if (deviceWidth >= 1200 && desktop != null) return desktop;
    if (deviceWidth >= 600 && tablet != null) return tablet;
    return mobile;
  }
}

extension ExtendedNavigator on BuildContext {
  Object? get routeArguments => ModalRoute.of(this)?.settings.arguments;

  Object? get routeName => ModalRoute.of(this)?.settings.name;

  Object? get routeSettings => ModalRoute.of(this)?.settings;

  ///  just call this [canPop()] method and it would return true if this route can be popped and false if it’s not possible.
  bool get canPop => Navigator.canPop(this);

  /// performs a simple [Navigator.pop] action and returns given [result]
  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);

  /// perform replash with routeName
  void popUntil(String screenName, {bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator)
          .popUntil(ModalRoute.withName(screenName));

  /// performs a simple [Navigator.push] action with given [route]
  Future<T?> push<T extends Object?>(
    Widget screen, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool rootNavigator = false,
  }) async =>
      await Navigator.of(
        this,
        rootNavigator: rootNavigator,
      ).push(MaterialPageRoute(
        builder: (_) => screen,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ));

  /// perform push and remove route
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget screen, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool routes = false,
    bool rootNavigator = false,
  }) async =>
      await Navigator.of(
        this,
        rootNavigator: rootNavigator,
      ).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ),
        (Route<dynamic> route) => routes,
      );

  /// perform push with routeName
  Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments, bool rootNavigator = false}) async =>
      await Navigator.of(this, rootNavigator: rootNavigator)
          .pushNamed(routeName, arguments: arguments);

  /// performs a simple [Navigator.pushReplacement] action with given [route]
  Future<T> pushReplacement<T extends Object?>(
    Widget screen, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool rootNavigator = false,
    dynamic result,
  }) async =>
      await Navigator.of(this, rootNavigator: rootNavigator).pushReplacement(
        MaterialPageRoute(
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ),
        result: result,
      );

  /// perform replash with routeName
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
    bool rootNavigator = false,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pushReplacementNamed(
          routeName,
          result: result,
          arguments: arguments);

  Object? get arguments => ModalRoute.of(this)?.settings.arguments;
}

extension SnackbarExt on BuildContext {
  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape,
    bool isDismissible = true,
    bool showIcon = false,
    IconData? icon,
    Color? iconColor,
    double? iconSize,
    TextStyle? textStyle,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    DismissDirection dismissDirection = DismissDirection.horizontal,
    double? actionOverflowThreshold,
    void Function()? onVisible,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showIcon) Icon(icon, color: iconColor, size: iconSize),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: textStyle,
              ),
            ),
          ],
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        elevation: elevation,
        margin: margin,
        padding: padding,
        shape: shape,
        behavior: behavior,
        onVisible: onVisible,
        dismissDirection: dismissDirection,
        actionOverflowThreshold: actionOverflowThreshold,
      ),
    );
  }
}

extension DialogExt on BuildContext {
  @Deprecated('use showAdaptiveAlertDialog')
  void showAlertDialog({
    required String title,
    required String message,
    List<String>? positiveButtonsTitle,
    String? cancelButtonTitle,
    Function(int)? onDone,
    Color? positiveTitleColor,
    Color? cancelTitleColor,
    double? fontSize,
    bool barrierDismissible = true,
  }) {
    // Check the platform
    if (MyPlatform.isIOS) {
      // show cuperino dialog
      _showIOSDialog(
        this,
        title,
        message,
        positiveButtonsTitle,
        cancelButtonTitle,
        onDone,
        positiveTitleColor,
        cancelTitleColor,
        fontSize,
        barrierDismissible,
      );
    } else {
      // shoe material dialog
      _showAndroidDialog(
        this,
        title,
        message,
        positiveButtonsTitle,
        cancelButtonTitle,
        onDone,
        positiveTitleColor,
        cancelTitleColor,
        fontSize,
        barrierDismissible,
      );
    }
  }

  void _showAndroidDialog(
      BuildContext context,
      String title,
      String message,
      List<String>? buttons,
      String? cancelButton,
      Function(int)? onDone,
      Color? positiveTitleColor,
      Color? cancelTitleColor,
      double? fontSize,
      bool barrierDismissible) {
    // flutter defined function
    List<Widget> arrWidget = [];

    if (cancelButton != null) {
      TextButton action = TextButton(
        style: TextButton.styleFrom(
          foregroundColor: cancelTitleColor,
          textStyle: TextStyle(
            fontSize: fontSize,
          ),
        ),
        child: Text(
          cancelButton,
        ),
        onPressed: () {
          context.pop();
        },
      );
      arrWidget.add(action);
    }

    if (buttons != null) {
      for (String buttonTitle in buttons) {
        TextButton action = TextButton(
          style: TextButton.styleFrom(
            foregroundColor: positiveTitleColor,
            textStyle: TextStyle(
              fontSize: fontSize,
            ),
          ),
          child: Text(
            buttonTitle,
          ),
          onPressed: () {
            int index = buttons.indexOf(buttonTitle);
            if (onDone != null) {
              onDone(index);
            }
            context.pop();
          },
        );
        arrWidget.add(action);
      }
    }

    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(title),
            content: Text(message),
            actions: arrWidget,
          );
        });
  }

  void _showIOSDialog(
      BuildContext context,
      String title,
      String message,
      List<String>? buttons,
      String? cancelButton,
      Function(int)? onDone,
      Color? positiveTitleColor,
      Color? cancelTitleColor,
      double? fontSize,
      bool barrierDismissible) {
    List<Widget> arrWidget = [];

    if (cancelButton != null) {
      CupertinoDialogAction action = CupertinoDialogAction(
        isDefaultAction: true,
        textStyle: TextStyle(color: cancelTitleColor, fontSize: fontSize),
        onPressed: () {
          context.pop();
        },
        child: Text(cancelButton),
      );
      arrWidget.add(action);
    }

    if (buttons != null) {
      for (String buttonTitle in buttons) {
        CupertinoDialogAction action = CupertinoDialogAction(
          isDefaultAction: true,
          textStyle: TextStyle(color: positiveTitleColor, fontSize: fontSize),
          onPressed: () {
            int index = buttons.indexOf(buttonTitle);
            if (onDone != null) {
              onDone(index);
            }
            context.pop();
          },
          child: Text(buttonTitle),
        );
        arrWidget.add(action);
      }
    }

    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: arrWidget,
          );
        });
  }

  Future<T?> showAdaptiveAlertDialog<T>({
    required String title,
    required String message,
    bool? barrierDismissible,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
    double? fontSize,
    String? cancelButtonText,
    Color? cancelButtonTextColor,
    Function()? onCancelPress,
    List<String>? positiveButtonTexts,
    Color? positiveTextColor,
    Function(int index)? onPositivePress,
  }) =>
      showAdaptiveDialog(
        context: this,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
        traversalEdgeBehavior: traversalEdgeBehavior,
        builder: (context) {
          List<Widget> actions = [];

          if (cancelButtonText != null) {
            actions.add(
              adaptiveAction(
                context: context,
                onPressed: () {
                  if (onCancelPress != null) {
                    onCancelPress.call();
                  } else {
                    context.pop();
                  }
                },
                child: Text(
                  cancelButtonText,
                  style: TextStyle(
                    color: cancelButtonTextColor,
                    fontSize: fontSize,
                  ),
                ),
              ),
            );
          }

          if (positiveButtonTexts != null) {
            for (String buttonText in positiveButtonTexts) {
              actions.add(
                adaptiveAction(
                  context: context,
                  onPressed: () {
                    int index = positiveButtonTexts.indexOf(buttonText);
                    context.pop();
                    if (onPositivePress != null) {
                      onPositivePress.call(index);
                    }
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: positiveTextColor,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              );
            }
          }

          return AlertDialog.adaptive(
            title: Text(title),
            content: Text(message),
            actions: actions,
          );
        },
      );

  Widget adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}

extension ThemeExt on BuildContext {
  //  THEMES

  /// performs a simple [Theme.of(context).appBarTheme] action and returns given [appBarTheme]
  AppBarTheme get appBarTheme => Theme.of(this).appBarTheme;

  /// performs a simple [Theme.of(context).backgroundColor] action and returns given [backgroundColor]
  Color get backgroundColor => Theme.of(this).colorScheme.surface;

  /// performs a simple [Theme.of(context).backgroundColor] action and returns given [backgroundColor]
  Color get surface => Theme.of(this).colorScheme.surface;

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Smallest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// performs a simple [Theme.of(context).bottomAppBarTheme] action and returns given [bottomAppBarTheme]
  BottomAppBarTheme get bottomAppBarTheme => Theme.of(this).bottomAppBarTheme;

  // COLOR

  /// performs a simple [Theme.of(context).bottomSheetTheme] action and returns given [bottomSheetTheme]
  BottomSheetThemeData get bottomSheetTheme => Theme.of(this).bottomSheetTheme;

  /// Largest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Middle size of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Smallest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// The color of [Divider]s and [PopupMenuDivider]s, also used
  /// between [ListTile]s, between rows in [DataTable]s, and so forth.
  ///
  /// To create an appropriate [BorderSide] that uses this color, consider
  /// [Divider.createBorderSide].
  Color get dividerColor => Theme.of(this).dividerColor;

  /// The focus color used indicate that a component has the input focus.
  Color get focusColor => Theme.of(this).focusColor;

  /// Largest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Middle size of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Smallest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// The hover color used to indicate when a pointer is hovering over a
  /// component.
  Color get hoverColor => Theme.of(this).hoverColor;

  /// Largest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  ///
  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Middle size of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Smallest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions
  TextStyle? get labelSmall => textTheme.labelSmall;

  /// performs a simple [Theme.of(context).primaryColor] action and returns given [primaryColor]
  Color get primaryColor => Theme.of(this).primaryColor;

  /// A darker version of the [primaryColor].
  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  /// A lighter version of the [primaryColor].
  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  /// performs a simple [Theme.of(context).primaryTextTheme] action and returns given [primaryTextTheme]
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  /// The default color of the [Material] that underlies the [Scaffold]. The
  /// background color for a typical material app or a page within the app.
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  TextTheme get textTheme => Theme.of(this).textTheme;

  /// performs a simple [Theme.of(context)] action and returns given [result]
  ThemeData get theme => Theme.of(this);

  /// Largest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Middle size of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Smallest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Checks if the current theme is dark.
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Checks if the current theme is light.
  bool get isLight => Theme.of(this).brightness == Brightness.light;
}
