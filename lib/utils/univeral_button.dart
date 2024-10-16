import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UniversalButton extends StatefulWidget {
  const UniversalButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColour,
    this.padding,
  });

  final Widget child;
  final Function() onPressed;
  final Color? backgroundColour;
  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => _UniversalButtonState();
}

class _UniversalButtonState extends State<UniversalButton> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? MaterialButton(
            color: widget.backgroundColour,
            onPressed: widget.onPressed,
            child: widget.child,
          )
        : Platform.isIOS
            ? CupertinoButton(
                color: widget.backgroundColour,
                onPressed: widget.onPressed,
                child: widget.child,
              )
            : MaterialButton(
                color: widget.backgroundColour,
                onPressed: widget.onPressed,
                child: widget.child,
              );
  }
}
