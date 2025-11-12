class ParameterModel {
  final bool isSelected;
  final String parameter;
  final String value;
  
  ParameterModel({
    required this.isSelected,
    required this.parameter,
    required this.value,
  });

  ParameterModel copyWith({
    bool? isSelected,
    String? parameter,
    String? value,
  }) {
    return ParameterModel(
      isSelected: isSelected ?? this.isSelected,
      parameter: parameter ?? this.parameter,
      value: value ?? this.value,
    );
  }
}
