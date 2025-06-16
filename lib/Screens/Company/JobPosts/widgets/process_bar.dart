import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:wazafny/core/constants/constants.dart';

const completeColor = primaryColor;
const inProgressColor = lightPrimary;
const todoColor = lightPrimary;

class ProcessTimelineBar extends StatelessWidget {
  final int processIndex;
  final List<String> processes;

  const ProcessTimelineBar({
    super.key,
    required this.processIndex,
    required this.processes,
  });

  Color getColor(int index) {
    if (index == processIndex) {
      return inProgressColor;
    } else if (index < processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      theme: TimelineThemeData(
        direction: Axis.horizontal,
        connectorTheme: const ConnectorThemeData(
          space: 30.0,
          thickness: 5.0,
        ),
        // Add this to control the overall timeline spacing
        nodePosition: 0.0, // This positions the nodes at the top
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtentBuilder: (_, __) =>
            MediaQuery.of(context).size.width / processes.length,
        contentsBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0), // Reduced from 15.0
            child: Text(
              processes[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          );
        },
        indicatorBuilder: (_, index) {
          return _buildIndicator(index);
        },
        connectorBuilder: (_, index, type) {
          return _buildConnector(index, type);
        },
        itemCount: processes.length,
      ),
    );
  }

  Widget _buildIndicator(int index) {
    Color color;
    Widget? child;

    if (index == processIndex) {
      color = inProgressColor;
      child = const Padding(
        padding: EdgeInsets.all(8.0),
      );
    } else if (index < processIndex) {
      color = completeColor;
      child = const Icon(
        Icons.check,
        color: Colors.white,
        size: 15.0,
      );
    } else {
      color = todoColor;
    }

    if (index <= processIndex) {
      return Stack(
        children: [
          CustomPaint(
            size: const Size(30.0, 30.0),
            painter: _BezierPainter(
              color: color,
              drawStart: index > 0,
              drawEnd: index < processIndex,
            ),
          ),
          DotIndicator(
            size: 30.0,
            color: color,
            child: child,
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          CustomPaint(
            size: const Size(15.0, 15.0),
            painter: _BezierPainter(
              color: color,
              drawEnd: index < processes.length - 1,
            ),
          ),
          OutlinedDotIndicator(
            borderWidth: 4.0,
            color: color,
          ),
        ],
      );
    }
  }

  Widget? _buildConnector(int index, ConnectorType type) {
    if (index > 0) {
      if (index == processIndex) {
        final prevColor = getColor(index - 1);
        final color = getColor(index);
        List<Color> gradientColors;
        if (type == ConnectorType.start) {
          gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
        } else {
          gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)!];
        }
        return DecoratedLineConnector(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
            ),
          ),
        );
      } else {
        return SolidLineConnector(
          color: getColor(index),
        );
      }
    } else {
      return null;
    }
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    double angle;
    Offset offset1;
    Offset offset2;

    Path path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
            size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
