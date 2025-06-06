import 'package:expenzo/main_screen/bloc/main_screen_bloc.dart';
import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/theme/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPopUp extends StatelessWidget {
  const CategoryPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(
          color: secondaryTextColor,
        ),
      ),
      backgroundColor: secondaryColor,
      title: Text(
        'Select Filter Category',
        style: appTheme.textTheme.title2.copyWith(color: secondaryTextColor),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            ExpenseCategory.values.length,
            (index) {
              return TextButton(
                onPressed: () {
                  context.read<MainScreenBloc>().add(
                        MainScreenEvent.filterExpenseByCategory(
                          expenseCategory: ExpenseCategory.values[index],
                        ),
                      );
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .7,
                  height: 40,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    ExpenseCategory.values[index].name,
                    style: TextStyle(color: primaryTextColor),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: secondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
