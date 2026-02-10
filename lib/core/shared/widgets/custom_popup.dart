import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../extensions/context_extensions.dart';
import 'custom_elevated_button.dart';
import 'custom_text.dart';

class CustomPopup extends StatefulWidget {
  final String title;
  final String? message;
  final Widget? content;
  final bool showTextField;
  final String? textFieldHint;
  final String? initialValue;
  final Function(String?)? onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;

  const CustomPopup({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.showTextField = false,
    this.textFieldHint,
    this.initialValue,
    this.onConfirm,
    this.onCancel,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    bool showTextField = false,
    String? textFieldHint,
    String? initialValue,
    Function(String?)? onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext context) {
        return CustomPopup(
          title: title,
          message: message,
          content: content,
          showTextField: showTextField,
          textFieldHint: textFieldHint,
          initialValue: initialValue,
          onConfirm: onConfirm,
          onCancel: onCancel,
          confirmText: confirmText,
          cancelText: cancelText,
        );
      },
    );
  }

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue ?? '');
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (widget.onConfirm != null) {
      if (widget.showTextField) {
        widget.onConfirm!(_textController.text);
      } else {
        widget.onConfirm!(null);
      }
    }
    Navigator.of(context).pop(true);
  }

  void _handleCancel() {
    if (widget.onCancel != null) {
      widget.onCancel!();
    }
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.widthPercent(0.85),
                maxHeight: context.heightPercent(0.7),
              ),
              padding: EdgeInsets.all(context.widthPercent(0.06)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cardBackground.withValues(alpha: 0.95),
                    AppColors.secondaryDark.withValues(alpha: 0.95),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(context.widthPercent(0.06)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20.0,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppColors.glowColor.withValues(alpha: 0.2),
                    blurRadius: 30.0,
                    offset: const Offset(0, 0),
                  ),
                ],
                border: Border.all(
                  color: AppColors.accentBlue.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    text: widget.title,
                    fontSize: context.largeTextSize,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    enableGlow: true,
                    enableShadow: true,
                  ),
                  SizedBox(height: context.heightPercent(0.03)),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.message != null)
                            CustomText(
                              text: widget.message!,
                              fontSize: context.mediumTextSize,
                              textAlign: TextAlign.center,
                              enableGlow: false,
                              color: AppColors.textSecondary,
                            ),
                          if (widget.content != null) widget.content!,
                          if (widget.showTextField) ...[
                            if (widget.message != null)
                              SizedBox(height: context.heightPercent(0.02)),
                            TextField(
                              controller: _textController,
                              autofocus: true,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: context.mediumTextSize,
                              ),
                              decoration: InputDecoration(
                                hintText: widget.textFieldHint ?? 'Enter text',
                                hintStyle: TextStyle(
                                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                                ),
                                filled: true,
                                fillColor: AppColors.secondaryDark.withValues(alpha: 0.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(context.widthPercent(0.03)),
                                  borderSide: BorderSide(
                                    color: AppColors.accentBlue.withValues(alpha: 0.3),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(context.widthPercent(0.03)),
                                  borderSide: BorderSide(
                                    color: AppColors.accentBlue.withValues(alpha: 0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(context.widthPercent(0.03)),
                                  borderSide: BorderSide(
                                    color: AppColors.accentBlue,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.heightPercent(0.03)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.cancelText.isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: context.widthPercent(0.02),
                            ),
                            child: CustomElevatedButton(
                              text: widget.cancelText,
                              onPressed: _handleCancel,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.textSecondary.withValues(alpha: 0.6),
                                  AppColors.textSecondary.withValues(alpha: 0.4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              fontSize: context.mediumTextSize,
                            ),
                          ),
                        ),
                      if (widget.confirmText.isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.cancelText.isNotEmpty ? context.widthPercent(0.02) : 0,
                            ),
                            child: CustomElevatedButton(
                              text: widget.confirmText,
                              onPressed: _handleConfirm,
                              fontSize: context.mediumTextSize,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
