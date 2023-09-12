import 'package:flutter/material.dart';
import 'package:dineseater_client_gilson/ui/common/app_colors.dart';
import 'package:dineseater_client_gilson/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'num_keypad_sheet_model.dart';

class NumKeypadSheet extends StackedView<NumKeypadSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const NumKeypadSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NumKeypadSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(199, 203, 210, 1),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(10),
        //   topRight: Radius.circular(10),
        // ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '4',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '5',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '6',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '7',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '8',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => print('hi'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    '9',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => print('hi'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  @override
  NumKeypadSheetModel viewModelBuilder(BuildContext context) =>
      NumKeypadSheetModel();
}
