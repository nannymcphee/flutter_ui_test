import 'package:flutter/material.dart';

class WButtonInkwell extends StatelessWidget {
  const WButtonInkwell(
      {Key key,
        this.splashColor,
        this.backgroundColor,
        this.onPressed,
        this.title,
        this.borderRadius,
        this.size,
        this.child})
      : super(key: key);

  final Color splashColor;
  final Widget child;
  final Function() onPressed;
  final BorderRadius borderRadius;
  final Size size;
  final Color backgroundColor;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          child: Stack(
            children: <Widget>[
              InkWell(
                splashColor: splashColor ?? Colors.white60.withOpacity(0.05),
                highlightColor: splashColor ?? Colors.white60.withOpacity(0.05),
                onTap: () {
                  onPressed();
                },
                borderRadius: borderRadius,
                child: Ink(
                  width: size.width ?? MediaQuery.of(context).size.width,
                  height: size.height ?? 70.0,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: backgroundColor),
                  child: Center(
                    child: title,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
