import 'package:flutter/material.dart';
import 'core/shared/widgets/custom_popup.dart';
import 'core/shared/widgets/custom_elevated_button.dart';
import 'core/shared/widgets/custom_text.dart';
import 'core/shared/theme/app_colors.dart';
import 'core/shared/extensions/context_extensions.dart';

class TestPopupScreen extends StatefulWidget {
  const TestPopupScreen({super.key});

  @override
  State<TestPopupScreen> createState() => _TestPopupScreenState();
}

class _TestPopupScreenState extends State<TestPopupScreen> {
  String _lastAction = 'No action yet';
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _showBasicPopup() {
    CustomPopup.show(
      context: context,
      title: 'Basic Popup',
      message: 'This is a basic popup with default buttons.',
      onConfirm: (_) {
        setState(() {
          _lastAction = 'Basic popup confirmed';
        });
      },
      onCancel: () {
        setState(() {
          _lastAction = 'Basic popup cancelled';
        });
      },
    );
  }

  void _showUsernamePopup() {
    CustomPopup.show(
      context: context,
      title: 'Enter Username',
      message: 'Please enter your username to continue',
      showTextField: true,
      textFieldHint: 'Username',
      confirmText: 'Save',
      cancelText: 'Cancel',
      onConfirm: (value) {
        setState(() {
          _lastAction = 'Username saved: ${value ?? ""}';
        });
      },
      onCancel: () {
        setState(() {
          _lastAction = 'Username entry cancelled';
        });
      },
    );
  }

  void _showCustomButtonsPopup() {
    CustomPopup.show(
      context: context,
      title: 'Custom Buttons',
      message: 'This popup has custom button labels.',
      confirmText: 'Accept',
      cancelText: 'Decline',
      onConfirm: (_) {
        setState(() {
          _lastAction = 'Custom popup accepted';
        });
      },
      onCancel: () {
        setState(() {
          _lastAction = 'Custom popup declined';
        });
      },
    );
  }

  void _showLongContentPopup() {
    CustomPopup.show(
      context: context,
      title: 'Long Content',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'This popup has scrollable content:',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            enableGlow: false,
          ),
          SizedBox(height: context.heightPercent(0.02)),
          ...List.generate(
            10,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: context.heightPercent(0.01)),
              child: CustomText(
                text: 'Item ${index + 1}: This is a long content item that demonstrates scrolling.',
                fontSize: 14,
                enableGlow: false,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
      onConfirm: (_) {
        setState(() {
          _lastAction = 'Long content popup confirmed';
        });
      },
      onCancel: () {
        setState(() {
          _lastAction = 'Long content popup cancelled';
        });
      },
    );
  }

  void _showDismissiblePopup() {
    CustomPopup.show(
      context: context,
      title: 'Dismissible Popup',
      message: 'Tap outside this popup to dismiss it.',
      onConfirm: (_) {
        setState(() {
          _lastAction = 'Dismissible popup confirmed';
        });
      },
      onCancel: () {
        setState(() {
          _lastAction = 'Dismissible popup cancelled';
        });
      },
    ).then((result) {
      if (result == null) {
        setState(() {
          _lastAction = 'Popup dismissed by tapping outside';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: context.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: context.heightPercent(0.02)),
                const CustomText(
                  text: 'CustomPopup Test',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CustomText(
                  text: 'Last Action: $_lastAction',
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: context.heightPercent(0.04)),
                CustomElevatedButton(
                  text: 'Show Basic Popup',
                  onPressed: _showBasicPopup,
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CustomElevatedButton(
                  text: 'Show Username Popup',
                  onPressed: _showUsernamePopup,
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CustomElevatedButton(
                  text: 'Show Custom Buttons',
                  onPressed: _showCustomButtonsPopup,
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CustomElevatedButton(
                  text: 'Show Long Content',
                  onPressed: _showLongContentPopup,
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CustomElevatedButton(
                  text: 'Show Dismissible Popup',
                  onPressed: _showDismissiblePopup,
                ),
                SizedBox(height: context.heightPercent(0.04)),
                const CustomText(
                  text: 'Features Tested:',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: context.heightPercent(0.02)),
                const CustomText(
                  text: '• Modal dialog with showDialog',
                  fontSize: 14,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                const CustomText(
                  text: '• Backdrop blur effect',
                  fontSize: 14,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                const CustomText(
                  text: '• Fade-in and scale animations',
                  fontSize: 14,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                const CustomText(
                  text: '• Custom title, content, and buttons',
                  fontSize: 14,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                const CustomText(
                  text: '• Dismissible on backdrop tap',
                  fontSize: 14,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                const CustomText(
                  text: '• Scrollable content support',
                  fontSize: 14,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
