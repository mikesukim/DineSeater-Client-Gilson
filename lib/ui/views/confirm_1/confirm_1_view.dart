import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'confirm_1_viewmodel.dart';

class Confirm1View extends StackedView<Confirm1ViewModel> {
  const Confirm1View({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    Confirm1ViewModel viewModel,
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
  Confirm1ViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      Confirm1ViewModel();
}
