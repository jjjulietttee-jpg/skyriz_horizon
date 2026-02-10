import 'package:flutter/material.dart';
import 'core/shared/widgets/custom_elevated_button.dart';
import 'core/shared/theme/app_colors.dart';

class TestButtonScreen extends StatelessWidget {
  const TestButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  text: 'Default Button',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Default button pressed!')),
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Large Button',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Large button pressed!')),
                    );
                  },
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Custom Gradient',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Custom gradient pressed!')),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: CustomElevatedButton(
                    text: 'Flexible Button',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Flexible button pressed!')),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: CustomElevatedButton(
                    text: 'Expanded Button',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Expanded button pressed!')),
                      );
                    },
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
