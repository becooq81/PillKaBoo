import '../../core/pillkaboo_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'dart:ui' as ui;


class GestureSlider extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final Function(int) onValueChanged;

  const GestureSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    this.initialValue = 10,
    required this.onValueChanged,
  });

  @override
  State<GestureSlider> createState() => _GestureSliderState();
}

class _GestureSliderState extends State<GestureSlider> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  void increment() {
    if (currentValue < widget.maxValue) {
      setState(() {
        currentValue++;
        SemanticsService.announce("$currentValue ml", ui.TextDirection.ltr);
        widget.onValueChanged(currentValue);
      });
    }
  }

  void decrement() {
    if (currentValue > widget.minValue) {
      setState(() {
        currentValue--;
        SemanticsService.announce("$currentValue ml", ui.TextDirection.ltr);
        widget.onValueChanged(currentValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double thumbDiameter = 30.0;
    double trackHeight = 23.0;
    double thumbPositionPercentage = currentValue.toDouble() / (widget.maxValue - widget.minValue);
    double trackWidth = MediaQuery.of(context).size.width * 0.75; 
    double thumbPosition = thumbPositionPercentage * trackWidth;

    return Semantics(
      container: true,
      value: '$currentValue ml',
      increasedValue: '$currentValue ml',
      decreasedValue: '$currentValue ml',
      onIncrease: increment,
      onDecrease: decrement,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          var delta = details.primaryDelta ?? 0;
          if (delta < 0) {
            increment();
          } else if (delta > 0) {
            decrement();
          }
        },
        child: ExcludeSemantics(
          child: Container(
            height: trackHeight,
            decoration: BoxDecoration(
              color: PKBAppState().secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: thumbPosition,
                    decoration: BoxDecoration(
                      color: PKBAppState().primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Positioned(
                  left: thumbPosition - (thumbDiameter / 2),
                  child: Container(
                    height: thumbDiameter,
                    width: thumbDiameter,
                    decoration: BoxDecoration(
                      color: PKBAppState().primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}