import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'mobile_input_viewmodel.dart';

class MobileInputView extends StackedView<MobileInputViewModel> {
  const MobileInputView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MobileInputViewModel viewModel,
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
  MobileInputViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MobileInputViewModel();
}
