/// Dialog for entering life adjustments via number pad.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Result from the life adjustment dialog.
class LifeAdjustmentResult {
  /// The amount to adjust (always positive).
  final int amount;

  /// Whether to add (true) or subtract (false).
  final bool isAddition;

  const LifeAdjustmentResult({
    required this.amount,
    required this.isAddition,
  });

  /// The signed value to apply to life total.
  int get signedValue => isAddition ? amount : -amount;
}

/// Shows a number pad dialog for entering life adjustments.
///
/// Returns a [LifeAdjustmentResult] if confirmed, or null if dismissed.
Future<LifeAdjustmentResult?> showLifeAdjustmentDialog(
  BuildContext context, {
  required int quarterTurns,
}) {
  return showDialog<LifeAdjustmentResult>(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) => RotatedBox(
      quarterTurns: quarterTurns,
      child: const LifeAdjustmentDialog(),
    ),
  );
}

/// Number pad dialog for entering a life adjustment amount.
class LifeAdjustmentDialog extends StatefulWidget {
  const LifeAdjustmentDialog({super.key});

  @override
  State<LifeAdjustmentDialog> createState() => _LifeAdjustmentDialogState();
}

class _LifeAdjustmentDialogState extends State<LifeAdjustmentDialog> {
  String _enteredValue = '';

  void _onDigitPressed(String digit) {
    setState(() {
      // Limit to reasonable length (3 digits = up to 999)
      if (_enteredValue.length < 3) {
        _enteredValue += digit;
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_enteredValue.isNotEmpty) {
        _enteredValue = _enteredValue.substring(0, _enteredValue.length - 1);
      }
    });
  }

  void _onClear() {
    setState(() {
      _enteredValue = '';
    });
  }

  void _onConfirm(bool isAddition) {
    final amount = int.tryParse(_enteredValue) ?? 0;
    if (amount > 0) {
      Navigator.of(context).pop(LifeAdjustmentResult(
        amount: amount,
        isAddition: isAddition,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDisplay(),
            const SizedBox(height: 16),
            _buildNumberPad(),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.purpleDark.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        _enteredValue.isEmpty ? '0' : _enteredValue,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          children: [
            _buildDigitButton('1'),
            _buildDigitButton('2'),
            _buildDigitButton('3'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDigitButton('4'),
            _buildDigitButton('5'),
            _buildDigitButton('6'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDigitButton('7'),
            _buildDigitButton('8'),
            _buildDigitButton('9'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildActionButton(
              icon: Icons.backspace_outlined,
              onTap: _onBackspace,
              onLongPress: _onClear,
            ),
            _buildDigitButton('0'),
            _buildActionButton(
              icon: Icons.close,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDigitButton(String digit) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: AppColors.purpleDark,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _onDigitPressed(digit),
            child: Container(
              height: 56,
              alignment: Alignment.center,
              child: Text(
                digit,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: AppColors.purpleDark.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              height: 56,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 28,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final hasValue = _enteredValue.isNotEmpty && _enteredValue != '0';

    return Row(
      children: [
        Expanded(
          child: _buildConfirmButton(
            label: '−',
            color: const Color(0xFFE57373), // Red for subtract
            onTap: hasValue ? () => _onConfirm(false) : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildConfirmButton(
            label: '+',
            color: const Color(0xFF81C784), // Green for add
            onTap: hasValue ? () => _onConfirm(true) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton({
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;

    return Material(
      color: isEnabled ? color : color.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 64,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: isEnabled
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
