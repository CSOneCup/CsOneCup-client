import 'package:cs_onecup/core/constants/colors.dart';
import 'package:flutter/material.dart';

class RectangularElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? minimumSize;
  final double? elevation;

  const RectangularElevatedButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.minimumSize,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape:
        RoundedRectangleBorder(
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : BorderRadius.zero,
        ),

        backgroundColor: backgroundColor ?? AppColors.mainLightGray, // 기본 배경색
        textStyle: TextStyle( color: textColor ?? Colors.white), // 기본 텍스트 색상
        minimumSize: minimumSize ?? const Size(100, 40), // 기본 버튼 크기
        elevation: elevation ?? 2.0, // 기본 그림자 높이
      ),
      child: child ?? const Text('Button'), // 기본 버튼 내용
    );
  }
}
