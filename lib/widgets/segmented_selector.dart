import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SegmentedSelector<T> extends StatelessWidget {
  final List<T> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final String Function(T) labelBuilder;

  const SegmentedSelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = option == selectedValue;
          final isFirst = index == 0;
          final isLast = index == options.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.purple : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                    left: isFirst ? const Radius.circular(6) : Radius.zero,
                    right: isLast ? const Radius.circular(6) : Radius.zero,
                  ),
                ),
                child: Center(
                  child: Text(
                    labelBuilder(option),
                    style: AppTextStyles.segmentText.copyWith(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
