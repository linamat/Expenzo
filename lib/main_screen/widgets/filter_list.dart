import 'package:expenzo/main_screen/bloc/main_screen_bloc.dart';
import 'package:expenzo/main_screen/enums/filter_param.dart';
import 'package:expenzo/main_screen/widgets/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:expenzo/theme/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterList extends StatefulWidget {
  const FilterList({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  int selectedIndex = 0;
  static const filterNames = ['All', 'Today', 'This Week', 'Category'];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(filterNames.length, (index) {
        return GestureDetector(
          onTap: () {
            if (selectedIndex != index) {
              setState(() {
                selectedIndex = index;
              });
            }
            if (selectedIndex == 3) {
              showDialog(
                context: context,
                builder: (context) => CategoryPopUp(),
              );
            } else {
              context.read<MainScreenBloc>().add(
                    MainScreenEvent.filterExpenseByDate(
                      filterParam: FilterParam.values[index],
                    ),
                  );
            }
          },
          child: Container(
            width: screenWidth * .19,
            height: screenHeight * .04,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedIndex == index
                  ? white.withValues(alpha: 0.2)
                  : secondaryColor,
            ),
            alignment: Alignment.center,
            child: Text(
              filterNames[index],
              style: TextStyle(color: primaryTextColor),
            ),
          ),
        );
      }),
    );
  }
}
