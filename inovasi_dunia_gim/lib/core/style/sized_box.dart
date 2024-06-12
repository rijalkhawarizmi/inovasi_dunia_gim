

import 'package:flutter/widgets.dart';

class VerticalSizedBox extends StatelessWidget {
  const VerticalSizedBox({super.key,required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}


class HorizontalSizedBox extends StatelessWidget {
  const HorizontalSizedBox({super.key,required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}