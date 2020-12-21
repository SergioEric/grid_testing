library grid_testing;

import 'package:flutter/material.dart';

class GridTesting extends StatelessWidget {
  const GridTesting({
    Key key,
    @required this.height,
    @required this.width,
    @required this.child,
    this.mainAxisCount = 5,
    this.crossAxisCount = 10,
    this.color = Colors.red,
    this.opacity = 1.0,
  })  : assert(child != null),
        assert(
          child is! Expanded,
          "child can not be an Expanded Widget, consider wrapping in a Row or Column",
        ),
        assert(
          width != double.infinity,
          "width cant no be infinity, BuildGrid",
        ),
        assert(
          height != double.infinity,
          "height cant no be infinity, BuildGrid",
        ),
        assert(opacity >= 0.0 && opacity <= 1.0),
        super(key: key);

  /// height cant not be [double.infinity] as the Widget used to build the grid
  /// is a [Stack] one. In that way, we have to pass a known `height`.
  /// If you want to cover your entire scaffold, use [MediaQuery].of(context).size
  /// and pass the size.height; the same applies for [width] parameter
  final double height;

  /// width cant not be [double.infinity] as the Widget used to build the grid
  /// is a [Stack] one. In that way, we have to pass a known `width`.
  /// If you want to cover your entire scaffold, use [MediaQuery].of(context).size
  /// and pass the *size.width*; the same applies for [height] parameter
  final double width;

  /// The color used for drawing the grid, consider passing a color without the
  /// .withOpacity(xx) parameter as it already used in the color
  final Color color;

  /// child can not be an [Expanded] Widget,
  /// consider wrapping in a [Row] or [Column]
  final Widget child;

  /// indicates how many lines will have main(x) axis, you can interpreted as the
  /// rows of the grid
  final int mainAxisCount;

  /// indicates how many lines will have cross(y) axis, you can interpreted as the
  /// columns of the grid
  final int crossAxisCount;

  /// indicates grid lines opacity, this is used to set .withOpacity(opacity)
  /// to the [color]
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            child,
            //rows
            for (var i = 0; i <= mainAxisCount; i++) ...[
              Positioned(
                top: i == 0 ? 0 : height * (i / mainAxisCount) - 1,
                child: Container(
                  width: width,
                  height: 1,
                  color: color.withOpacity(opacity),
                ),
              ),
            ],
            //columns
            for (var i = 0; i <= crossAxisCount; i++) ...[
              Positioned(
                left: i == 0 ? 0 : width * (i / crossAxisCount) - 1,
                child: Container(
                  width: 1,
                  height: height,
                  color: color.withOpacity(opacity),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
