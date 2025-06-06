import 'package:expenzo/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  communal,
  transportation,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  Color toColor() {
    switch (this) {
      case ExpenseCategory.food:
        return accentColor1;
      case ExpenseCategory.communal:
        return accentColor2;
      default:
        return accentColor3;
    }
  }
}
