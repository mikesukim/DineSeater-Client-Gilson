import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'confirm_2_viewmodel.dart';

class Confirm2View extends StackedView<Confirm2ViewModel> {
  const Confirm2View({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    Confirm2ViewModel viewModel,
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
  Confirm2ViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      Confirm2ViewModel();
}
