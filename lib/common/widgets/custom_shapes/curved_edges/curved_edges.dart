import 'package:flutter/material.dart';

class TCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstControlPoint = Offset(0, size.height - 20);
    var lastControlPoint = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        lastControlPoint.dx, lastControlPoint.dy);
    var secondfirstControlPoint = Offset(0, size.height - 20);
    var secondlastControlPoint = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
        secondfirstControlPoint.dx,
        secondfirstControlPoint.dy,
        secondlastControlPoint.dx,
        secondlastControlPoint.dy);
    var thirdfirstControlPoint = Offset(size.width, size.height - 20);
    var thirdlastControlPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstControlPoint.dx, thirdfirstControlPoint.dy,
        thirdlastControlPoint.dx, thirdlastControlPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
