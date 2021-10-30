# rating_bar_flutter

A customizable *Rating Bar Flutter* for flutter with half rating support

[![pub package](https://img.shields.io/pub/v/rating_bar_flutter.svg?style=popout)](https://pub.dartlang.org/packages/rating_bar_flutter)

## Installation

Add this to your package's pubspec.yaml file

```yaml
dependencies:
  ...
  rating_bar_flutter: ^1.0.0
```

## Usage
First import the namespace

```dart
  import 'package:rating_bar/rating_bar_flutter.dart';
```
`onRatingChanged` callback returns current rating which is a double,
when the rating has changed.

```dart
  RatingBarFlutter(
    onRatingChanged: (rating) => setState(() => _rating = rating!),
    filledIcon: Icons.star,
    emptyIcon: Icons.star_border,
    halfFilledIcon: Icons.star_half,
    isHalfAllowed: true,
    aligns: Alignment.centerLeft,
    filledColor: Colors.green,
    emptyColor: Colors.redAccent,
    halfFilledColor: Colors.amberAccent, 
    size: 48,
  ),
```

You can also use read-only rating bar widget

```dart
  RatingBarFlutter.readOnly(
    initialRating: 3.5,
    isHalfAllowed: true,
    aligns: Alignment.centerLeft,
    halfFilledIcon: Icons.star_half,
    filledIcon: Icons.star,
    emptyIcon: Icons.star_border,
  ),
```


## License
[MIT License](https://github.com/joshmatta/rating_bar/blob/master/LICENSE)


## Inspire me
[Be a Patreon](https://www.patreon.com/join/_lutfor?)