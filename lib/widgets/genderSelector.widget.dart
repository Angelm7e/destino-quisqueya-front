import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:flutter/material.dart';

class GenderOption {
  final String value;
  final String label;
  final IconData icon;

  const GenderOption({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class GenderSelectorWidget extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;
  final String? labelText;

  const GenderSelectorWidget({
    super.key,
    this.selectedGender,
    required this.onChanged,
    this.labelText,
  });

  static const List<GenderOption> genderOptions = [
    GenderOption(value: 'M', label: 'M', icon: Icons.male),
    GenderOption(value: 'F', label: 'F', icon: Icons.female),
    GenderOption(value: 'O', label: 'Otro', icon: Icons.person),
  ];

  // Función helper para normalizar el valor del género
  static String? normalizeGender(String? value) {
    if (value == null || value.isEmpty) return null;
    final upperValue = value.toUpperCase();
    if (upperValue == 'M' || upperValue == '1' || upperValue == 'MASCULINO') {
      return 'M';
    }
    if (upperValue == 'F' || upperValue == '2' || upperValue == 'FEMENINO') {
      return 'F';
    }
    if (upperValue == 'O' ||
        upperValue == '3' ||
        upperValue == 'OTRO' ||
        upperValue == 'OTROS') {
      return 'O';
    }
    return 'O';
  }

  // Función helper para obtener el label del género
  static String getGenderLabel(String? value) {
    final normalized = normalizeGender(value);
    if (normalized == null) return 'Seleccionar género';
    return genderOptions.firstWhere((opt) => opt.value == normalized).label;
  }

  String? get normalizedSelectedGender {
    return normalizeGender(selectedGender);
  }

  @override
  Widget build(BuildContext context) {
    final normalizedGender = normalizedSelectedGender;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              labelText!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: genderOptions.asMap().entries.map((entry) {
            final option = entry.value;
            final index = entry.key;
            final isSelected = normalizedGender == option.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < genderOptions.length - 1 ? 12 : 0,
                ),
                child: GestureDetector(
                  onTap: () => onChanged(option.value),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.lightPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: AppColors.lightSecondary,
                              width: 1,
                            ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          option.icon,
                          color: isSelected
                              ? Colors.white
                              : (Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? Colors.white
                                  : (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary),
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
