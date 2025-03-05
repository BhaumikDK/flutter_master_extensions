## Let get started  
  
1. Go to `pubspec.yaml` 
2. add a flutter_master_extensions and replace `[version]` with the latest version: 

```dart  
dependencies:  
 flutter_master_extensions: ^[version]
 ```
  
3. click the packages get button or *flutter pub get* 

## About

An extension to the widget helps reduce the boilerplate and adds some helpful methods. and you can make a responsive design.

## Theme Extensions

#### TextStyle

From the `TextStyle` Access properties right in the `context` instance.

```dart
// Before
Text('Hello World',style: Theme.of(context).textTheme.labelSmall),

Text('Hello World', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 40)

// After
Text('Hello World',style: context.labelSmall),
// OR
Text('Hello World',style: context.displaySmall),
// If you want to bold text then
Text('Hello World',style: context.labelSmall?.bold),
```

FontWeight extensions that apply font weights on `TextStyle`:

- `mostThick` or `w900` The most thick - FontWeight.w900
- `extraBold` or `w800` Extra-bold - FontWeight.w800
- `bold` or `w700` Bold - FontWeight.bold - FontWeight.w700
- `semiBold` or `w600` Semi-bold - FontWeight.w600
- `medium` or `w500` Medium - FontWeight.w500
- `regular` or `w400` Regular - FontWeight.w400
- `light` or `w300` Light - FontWeight.w300
- `extraLight` or `w200` Extra-light - FontWeight.w200
- `thin` or `w100` Thin, the least thick - FontWeight.w100

Similar 2021 TextStyle are:

- `context.displayLarge`
- `context.displayMedium`
- `context.displaySmall`
- `context.headlineLarge`
- `context.headlineMedium`
- `context.headlineSmall`
- `context.titleLarge`
- `context.titleMedium`
- `context.titleSmall`
- `context.bodyLarge`
- `context.bodyMedium`
- `context.bodySmall`
- `context.labelLarge`
- `context.labelMedium`
- `context.labelSmall`


#### Text

If you dont want use theme, then we have some other methods:

```dart
Text('Hello World')
    .bold()
    .fontSize(25)
    .italic();
```

Similar methods are:

- `textScale()` TextScale
- `bold` Bold Text
- `italic()` Italic Text
- `fontWeight()` Specific FontWeight
- `fontSize()` Specific FontSize
- `letterSpacing()` Specific LetterSpacing
- `height()` Specific Height
- `wordSpacing()` Specific WordSpacing
- `fontFamily()` Specific FontFamily
- `textShadow()` Specific TextShadow
- `textColor()` TextColor
- `textAlignment()` Specific TextAlignment
- `withUnderLine()` TextUnderLine

#### Theme

From the `Theme` class. Access your themes right in the `context` instance.

- `context.theme`
- `context.textTheme`
- `context.primaryTextTheme`
- `context.bottomAppBarTheme`
- `context.bottomSheetTheme`
- `context.appBarTheme`
- `context.backgroundColor`
- `context.primaryColor`
- `context.primaryColorLight`
- `context.primaryColorDark`
- `context.focusColor`
- `context.hoverColor`
- `context.dividerColor`
- `context.scaffoldBackgroundColor`


## Media Query Extensions For Responsive Layout

From the `MediaQuery` Access properties right in the `context` instance.

```dart
// Before
 Container(
     width: MediaQuery.of(context).size.width,
     height: MediaQuery.of(context).size.width,
        )
// After
Container(
     width: context.deviceWidth,
     height: context.deviceWidth,
        )
```

Similar extensions are:

- `context.deviceHeight` /// Height of the Screen,
- `context.deviceWidth` // Width of Screen
- `context.mediaQuerySize`
- `context.orientation`
- `context.mediaQueryPadding`
- `context.alwaysUse24HourFormat`
- `context.devicePixelRatio`
- `context.platformBrightness`
- `context.textScaleFactor`
- `context.isLandscape`
- `context.isPortrait`
- `context.mediaQueryViewPadding`
- `context.mediaQueryViewInsets`
- `context.mediaQueryShortestSide`
- `context.showNavbar` // True if width be larger than 800
- `context.isPhone` // True if the shortestSide is smaller than 600p
- `context.isTablet` // True if the current device is Tablet
- `context.isSmallTablet` // True if the shortestSide is largest than 600p
- `context.isLargeTablet` // True if the shortestSide is largest than 720p

MediaQuery as Inherited Model
Old Way X

MediaQuery.of(context).size;
MediaQuery.of(context).padding; MediaQuery.of (context). orientation;
By calling MediaQuery.of(context).size, the widget will rebuild when any of the MediaQuery properties change (less performant).

New Way ✓

MediaQuery.sizeof(context);
MediaQuery.paddingOf(context); MediaQuery.orientation of (context);
By calling MediaQuery.sizeof(context), the widget will rebuild only when the size changes, avoiding unnecessary rebuilds.

- `context.mqSize` // The same of MediaQuery.sizeOf(context)
- `context.mqHeight` // The same of MediaQuery.sizeOf(context).height
- `context.mqWidth`
- `context.mqPadding` // similar to [MediaQuery.paddingOf(context)]
- `context.mqViewPadding`
- `context.mqViewInsets`
- `context.mqOrientation`
- `context.mqAlwaysUse24HourFormat`
- `context.mqDevicePixelRatio`
- `context.mqPlatformBrightness`
- `context.mqTextScaleFactor`

```dart
//Check in what platform the app is running
MyPlatform.isAndroid
MyPlatform.isIOS
MyPlatform.isMacOS
MyPlatform.isWindows
MyPlatform.isLinux
MyPlatform.isFuchsia

//Check the device type
MyPlatform.isMobile
MyPlatform.isDesktop
//All platforms are supported independently in web!
//You can tell if you are running inside a browser
//on Windows, iOS, OSX, Android, etc.
MyPlatform.isWeb


// Returns a value<T> according to the screen size
// can give value for:
// mobile: if the shortestSide is smaller than 600
// tablet: if the shortestSide is smaller than 1200
// desktop: if width is largest than 1200
context.responsiveValue<T>(T? mobile, T? tablet, T? desktop),

// Example
Container(
    child: context.responsiveValue(
        mobile: Container(
          color: Colors.yellow,
          width: context.deviceWidth,
          height: context.deviceHeight,
        ),
        tablet: Container(
          color: Colors.green,
          width: context.deviceWidth,
          height: context.deviceHeight,
        ),
        desktop: Container(
          color: Colors.black,
          width: context.deviceWidth,
          height: context.deviceHeight,
        )),
     )
```

## Navigation Extensions

From the `Navigator` Access properties right in the `context` instance.

```dart
// Before
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondScreen()),
  );

// After

// for push
context.push(SecondScreen());
context.pushNamed('/home');

// for back , you can also add back result data
context.pop;

// for replace
context.pushReplacement(SecondScreen());
context.pushReplacementNamed('/home');

// popUntil
context.popUntil('/login');

// with rootNavigator
context.push(SecondScreen(), rootNavigator: true);
context.pushReplacement(SecondScreen(), rootNavigator: true);
context.popUntil('/login', rootNavigator: true);

context.routeSettings;
context.routeName;
context.routeArguments;
```


### .httpGet()
Sends an HTTP GET request with the given headers to the given URL
```dart
final json = await "https://jsonplaceholder.typicode.com/posts".httpGet();
```
*result:*
```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere",
    "body": "quia et suscipit"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "dolor beatae ea dolores neque"
  },
]
```

*usage with then:*
```dart
"https://jsonplaceholder.typicode.com/posts".httpGet().then((result) {
          print(result);
       }).catchError((e) => print(e));
```

### .httpPost()
Sends an HTTP POST request with the given headers and body to the given URL which can be a [Uri] or a [String].
```dart
String json = '{"title": "Hello", "body": "body text", "userId": 1}';
final json = await "https://jsonplaceholder.typicode.com/posts".httpPost(json);
```

## Widget Extensions

This extension is reduced more code.

### SizedBox
```dart
// For giving an height 

// Before
SizedBox(
  height: 10.0,
);

// After
10.0.toVSB,

// For giving an Width

//Before
SizedBox(
  width: 10.0,
);

// After
10.0.toHSB,
```

### Padding

```dart
// Before
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text("text"),
);

// After
Text("text").paddingAll(8.0),
```

Similar padding extensions are:

- `toAllPadding` Creates insets from offsets from all side.
- `toHorizontalPadding` Creates insets with symmetrical horizontal offsets
- `toVerticalPadding` Creates insets with symmetrical vertical offsets
- `toOnlyPadding` Creates insets with only the given values non-zero.
- `paddingLTRB` Creates insets from offsets from the left, top, right, and bottom.
- `toSymmetricPadding` Creates insets with symmetrical vertical and horizontal offsets.


### Radius / BorderRadius
```dart
// For giving an Circlular Radius to any respective widget 

// Before
Radius.circular(10.0)

// After
10.0.toRadius,

// For giving an All Border Radius to any respective widget 

//Before
BorderRadius.all(Radius.circular(10.0));

// After
10.0.toAllRadius,

// For giving an All Border Radius to any respective widget

//Before
BorderRadius.circular(10.0);

// After
10.0.toAllBorderRadius,
```


### Opacity

```dart
// Before
Opacity(
  opacity: 0.5,
  child: Text("text"),
)

// After
Text("text").setOpacity(0.5)
```

### Expanded

```dart
/// Before
Expanded(
  child: Text("text"),
)

// After
Text("text").toExpanded()
```

### Flexible

```dart
/// Before
Flexible(
  child: Text("text"),
)

// After
Text("text").toFlexible()
```

#### Shimmer Effect

![OYCE3](https://user-images.githubusercontent.com/31765271/177955655-66a856a6-108a-429f-bbad-64b1c3f114aa.gif)

```dart
Container(height: 50,width: 50,).applyShimmer();
```

### SliverToBoxAdapter

```dart
Text(text).toSliver;
// is same as
SliverToBoxAdapter(
  child: Text(text),
);
```

you can also change color of shimmer using `Color baseColor`, `Color highlightColor`.


#### Other

Now we can just add round corners, shadows, align, and added gestures to our Widgets.

Automatic detect platform and show material and cupertino dialog

```dart
context.showAlertDialog(title: 'title',
                        message: 'message',)
```

#### SeparatedBy

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text('Hello').toAllPadding(5),
    const Text('World').toAllPadding(5),
    const Text('Seperated').toAllPadding(5),
    const Text('By').toAllPadding(5),
    const Text('Commas').toAllPaddingS(5),
  ].separatedby(
    const Text(','),
  ),
),
```

## Date Extensions

```dart
// for check two date are same or not
date.isSameDate(otherdate);    // its return bool (true/false)

// for check date is today's date
date.isToday    // its return bool (true/false)

// for check this date is yesterday's date
date.isYesterday    // its return bool (true/false)
```

## Int/Number Extensions

#### Future & Duration

Utility to delay some callback (or code execution).

```dart
print('+ wait for 2 seconds');
await 2.delay();
print('- 2 seconds completed');
print('+ callback in 1.2sec');
1.delay(() => print('- 1.2sec callback called'));
```

Easy way to make Durations from numbers.

```dart
print(1.seconds + 200.milliseconds);
print(1.hours + 30.minutes);
print(1.5.hours);

5.isLowerThan(4);
5.isGreaterThan(4);
5.isEqual(4);
```

## Range Extensions
### .until()
Returns a sequence of integer, starting from the current number until the [end] number. [step] is optional, it will step number if given
```dart
for(final num in 1.until(10)) {
  numbers.add(num); 
}
```
*result*
```dart
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```
with step:
```dart
for(final num in 1.until(10, step: 2)) {
  numbers.add(num); 
}
```
*result*
```dart
[1, 3, 5, 7, 9]
```

## String Extensions

```dart
//your name => Your Name,
'your name'.capitalized;
//your name => Your name,
'your name'.capitalizeFirst;
//your name => yourname
'your name'.removeAllWhitespace;

// match any RegExp
'dsts'.hasMatch("'r'[A-Z]");
//return bool if match RegExp
'123'.isNumericOnly;
'dsf'.isAlphabetOnly;
'Ajh'.hasCapitalletter;
```

## Iterable Extensions

### .any()
Returns `true` if at least one element matches the given predicate.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn")]; 
users.any((u) => u.name == 'Kasey') // true
```

### .groupBy()
Groups the elements in values by the value returned by key.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 

users.groupBy((u) => u.age); 
```
Sort the users by age:
```dart
{  
  22: [User:22, Kasey, User:22, Rene], 
  23: [User:23, Jadn], 
  32: [User:32, Aden]
}
```

### .sortBy()
Sorts elements in the array in-place according to natural sort order of the value returned by specified selector function.
```dart
final users = [User(22, "Kasey"), User(16, "Roni"), User(23, "Jadn")]; 
users.sortBy((u) => u.age) ///  [User(16, "Roni"), [User(22, "Kasey"), User(23, "Jadn")]
```

### .find()
Returns the first element matching the given predicate, or `null` if element wasn't found.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 

users.find((u) => u.name == "Rene") // User(22, "Rene")
```

### .chunks()
Splits the Iterable into chunks of the specified `size`
```dart
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(3)) 
```
*result*
```dart
([1, 2, 3], [4, 5, 6], [7, 8, 9], [10])
```

### .filter() 
 Returns a list containing only elements matching the given predicate, the return type will be `List`,
 unlike the `where` operator that return `Iterator`,  also it filters null.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 
final filtered = users.filter((u) => u.name == "Kasey"); // [User(22, "Kasey")] <- Type List<User>

final listWithNull = [null, User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")];
final filtered = listWithNull.filter((u) => u.name == "Jadn"); // [User(23, "Jadn")]
```

### .intersect()
Returns a set containing all elements that are contained by both this set and the specified collection.
```dart
Set.from([1, 2, 3, 4]).intersect(Set.from([3, 4, 5, 6]) // 1,2,3,4,5,6
```

### .filterNot() 
 Returns a list containing only not the elements matching the given predicate, the return type will be `List`,
 unlike the `where` operator that return `Iterator`,  also it filters null.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 
final filtered = users.filterNot((u) => u.name == "Kasey"); // [User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")] <- Type List<User>

final listWithNull = [null, User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")];
final filtered = listWithNull.filterNot((u) => u.name == "Jadn"); // [User(22, "Rene"), User(32, "Aden")]
```

### .takeOnly() 
Returns a list containing first [n] elements.
```dart
[1, 2, 3, 4].takeOnly(1) // [1]
```

### .drop() 
Returns a list containing all elements except first [n] elements.
```dart
[1, 2, 3, 4].drop(1) // [2, 3, 4]
```

### .forEachIndexed()
Performs the given action on each element on iterable, providing sequential `index` with the `element`.
```dart
["red","green","blue"].forEachIndexed((item, index) { 
	print("$item, $index"); 
}); // 0: red // 1: green // 2: blue
```

### .sortedDescending()  
Returns a new list with all elements sorted according to descending natural sort order.
```dart  
var list = [1,2,3,4,5];  
final descendingList = list.sortedDescending();  
print(descendingList); // [5, 4, 3, 2, 1]
```  
  
### .count()  
Return a number of the existing elements by a specific predicate
```dart  
final users = [User(33, "Miki"), User(45, "Anna"), User(19, "Amit")];  
  
final aboveAgeTwenty = users.count((user) => user.age > 20);  
print(aboveAgeTwenty); // 2
```

### .associate()  
Creates a Map instance in which the keys and values are computed from the iterable.
```dart  
final users = [User(33, "Miki"), User(45, "Anna"), User(19, "Amit")];  

users.associate((k) => k.name, (e) => e.age) // {'Miki': 33, 'Anna': 45, 'Amit': 19}
```

### .concatWithMultipleList()  
Return a list concatenates the output of the current list and multiple iterables.
```dart  
  final listOfLists = [
        [5, 6, 7],
        [8, 9, 10]
      ];
  [1, 2, 3, 4].concatWithMultipleList(listOfLists); 
  
  // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```
  
### .distinctBy()  
Returns a list containing only the elements from given collection having distinct keys.
```dart  
// example 1
final users = ["Zack", "Ian", "Ronit"];  
users.distinctBy((u) => u.toLowerCase().startsWith("z")); // Zack 

// example 2
final users = [User(11, 'idan'), User(12, 'ronit'), User(11, 'asaf')];
	
final dist = users.distinctBy((u) => u.age);    
dist.forEach((u) => print(u.age)); //  11, 12
```  
  
### .zip()  
Zip is used to combine multiple iterables into a single list that contains  the combination of them two.
```dart  

final soldThisMonth = [Motorcycle(2020, 'BMW R1200GS'), Motorcycle(1967, 'Honda GoldWing')];
final soldLastMonth = [Motorcycle(2014, 'Honda Transalp'), Motorcycle(2019, 'Ducati Multistrada')];    
  
final sales = soldThisMonth.zip(soldLastMonth).toList();  
  				
print(sales); 
// [
//  [brand: BMW R1200GS year: 2020, brand: Honda Transalp year: 2014], // first pair from this month and last
//  [brand: Honda GoldWing year: 1967, brand: Ducati Multistrada year: 2019] // second pair from last month 
// ]
```  

## Support

You liked this package? then give it a star. If you want to help then:

- Share this package
- Create issues if you find a Bug or want to suggest something
