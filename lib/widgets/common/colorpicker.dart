import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

typedef LayoutBuilder = Widget Function(
    BuildContext context, Color color, VoidCallback callback);

// refer: https://github.com/mchome/flutter_colorpicker
const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

Random _random = Random();

class ColorPickingController extends ValueNotifier<Color> {
  ColorPickingController({
    Color color,
  }) : super(color == null
            ? _defaultColors[_random.nextInt(_defaultColors.length)]
            : color);

  Color get color => value;
  set color(newColor) => value = (newColor == null
      ? _defaultColors[_random.nextInt(_defaultColors.length)]
      : newColor);
}

class ColorPickerRaisedButtonWidget extends StatefulWidget {
  final Color initialColor;
  final ColorPickingController controller;
  final VoidCallback onLongPress;
  final ValueChanged<bool> onHighlightChanged;
  final ButtonTextTheme textTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color disabledColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final Brightness colorBrightness;
  final double elevation;
  final double focusElevation;
  final double hoverElevation;
  final double highlightElevation;
  final double disabledElevation;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final MaterialTapTargetSize materialTapTargetSize;
  final Duration animationDuration;
  final Widget child;

  const ColorPickerRaisedButtonWidget({
    Key key,
    this.initialColor,
    this.controller,
    this.onLongPress,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.animationDuration,
    this.child,
  })  : assert(initialColor == null || controller == null),
        super(key: key);

  @override
  _ColorPickerRaisedButtonWidgetState createState() =>
      _ColorPickerRaisedButtonWidgetState();

  static Color counterColor(color) {
    return useWhiteForeground(color) ? Colors.white : Colors.black;
  }
}

class _ColorPickerRaisedButtonWidgetState
    extends State<ColorPickerRaisedButtonWidget> {
  ColorPickingController _controller;
  ColorPickingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ColorPickingController(color: widget.initialColor);
      _controller.addListener(_handleControllerChanged);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  // 여기에 itemBuilder를 넣어볼까?
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: widget.key,
      onPressed: () => _pickColor(context),
      onLongPress: widget.onLongPress,
      onHighlightChanged: widget.onHighlightChanged,
      textTheme: widget.textTheme,
      textColor: ColorPickerRaisedButtonWidget.counterColor(
          _effectiveController.color),
      disabledTextColor: widget.disabledTextColor,
      color: _effectiveController.color,
      disabledColor: widget.disabledColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      highlightColor: widget.highlightColor,
      splashColor: widget.splashColor,
      colorBrightness: widget.colorBrightness,
      elevation: widget.elevation,
      focusElevation: widget.focusElevation,
      hoverElevation: widget.hoverElevation,
      highlightElevation: widget.highlightElevation,
      disabledElevation: widget.disabledElevation,
      padding: widget.padding,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      materialTapTargetSize: widget.materialTapTargetSize,
      animationDuration: widget.animationDuration,
      child: widget.child,
    );
  }

  void _pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              availableColors: _defaultColors,
              pickerColor: _effectiveController.color,
              onColorChanged: (color) => _effectiveController.color = color,
            ),
          ),
        );
      },
    );
  }

  void _handleControllerChanged() {
    setState(() {});
  }
}
