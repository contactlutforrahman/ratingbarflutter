/// library to call for the rating bar
library rating_bar_flutter;

import 'package:flutter/material.dart';

/// callback for ratting changed value
typedef void RatingCallback(double? rating);

/// Rating Bar class for flutter to implement the rating
class RatingBarFlutter extends StatefulWidget {
  RatingBarFlutter({
    Key? key,
    this.maxRating = 5,
    required this.onRatingChanged,
    required this.filledIcon,
    required this.emptyIcon,
    this.halfFilledIcon,
    this.isHalfAllowed = false,
    this.aligns = Alignment.centerLeft,
    this.initialRating = 0.0,
    this.filledColor,
    this.emptyColor = Colors.grey,
    this.halfFilledColor,
    this.size = 40,
  })  : _readOnly = false,
        assert(!isHalfAllowed || halfFilledIcon != null),
        super(key: key);

  RatingBarFlutter.readOnly({
    Key? key,
    this.maxRating = 5,
    required this.filledIcon,
    required this.emptyIcon,
    this.halfFilledIcon,
    this.isHalfAllowed = false,
    this.aligns = Alignment.centerLeft,
    this.initialRating = 0.0,
    this.filledColor,
    this.emptyColor = Colors.grey,
    this.halfFilledColor,
    this.size = 40,
  })  : _readOnly = true,
        onRatingChanged = null,
        assert(!isHalfAllowed || halfFilledIcon != null),
        super(key: key);

  /// max rating value goes here
  final int maxRating;

  /// filled icon
  final IconData filledIcon;

  /// empty icon
  final IconData emptyIcon;

  /// half filled icon
  final IconData? halfFilledIcon;

  /// call back for ratting changed value
  final RatingCallback? onRatingChanged;

  /// initial rating value
  final double initialRating;

  /// rating filled color
  final Color? filledColor;

  /// empty color
  final Color emptyColor;

  /// half filled rating color
  final Color? halfFilledColor;

  /// rating size
  final double size;
  final bool isHalfAllowed;
  final Alignment aligns;

  /// if the rating bar is read only
  final bool _readOnly;

  @override
  _RatingBarFlutterState createState() {
    return _RatingBarFlutterState();
  }
}

class _RatingBarFlutterState extends State<RatingBarFlutter> {
  /// takes the current rating value
  double? _currentRating;
  late Alignment _algins;
  @override
  void initState() {
    super.initState();
    _algins = widget.aligns;
    if (widget.isHalfAllowed) {
      _currentRating = widget.initialRating;
    } else {
      _currentRating = widget.initialRating.roundToDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _algins,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.maxRating, (index) {
          return Builder(
            builder: (rowContext) => widget._readOnly
                ? buildIcon(context, index + 1)
                : buildStar(rowContext, index + 1),
          );
        }),
      ),
    );
  }

  Widget buildIcon(BuildContext context, int position) {
    IconData? iconData;
    Color color;
    double? rating;
    if (widget._readOnly) {
      if (widget.isHalfAllowed) {
        rating = widget.initialRating;
      } else {
        rating = widget.initialRating.roundToDouble();
      }
    } else {
      rating = _currentRating;
    }
    if (position > rating! + 0.5) {
      iconData = widget.emptyIcon;
      color = widget.emptyColor;
    } else if (position == rating + 0.5) {
      iconData = widget.halfFilledIcon;
      color = widget.halfFilledColor ??
          widget.filledColor ??
          Theme.of(context).primaryColor;
    } else {
      iconData = widget.filledIcon;
      color = widget.filledColor ?? Theme.of(context).primaryColor;
    }
    return Icon(iconData, color: color, size: widget.size);
  }

  Widget buildStar(BuildContext context, int position) {
    return GestureDetector(
      child: buildIcon(context, position),
      onTap: () {
        setState(() => _currentRating = position.toDouble());
        widget.onRatingChanged!(_currentRating);
      },
      onHorizontalDragUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        var localPosition = renderBox.globalToLocal(details.globalPosition);
        var rating = localPosition.dx / widget.size;

        if (rating < 0) {
          rating = 0;
        } else if (rating > widget.maxRating) {
          rating = widget.maxRating.toDouble();
        } else {
          rating = widget.isHalfAllowed
              ? (2 * rating).ceilToDouble() / 2
              : rating.ceilToDouble();
        }
        if (_currentRating != rating) {
          setState(() => _currentRating = rating);
          widget.onRatingChanged!(_currentRating);
        }
      },
    );
  }
}
