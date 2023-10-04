import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'party_size_viewmodel.dart';

class PartySizeView extends StackedView<PartySizeViewModel> {
  const PartySizeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PartySizeViewModel viewModel,
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
  PartySizeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PartySizeViewModel();
}
