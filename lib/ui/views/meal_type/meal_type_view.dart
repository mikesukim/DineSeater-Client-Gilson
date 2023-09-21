import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'meal_type_viewmodel.dart';

class MealTypeView extends StackedView<MealTypeViewModel> {
  const MealTypeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MealTypeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  MealTypeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MealTypeViewModel();
}
