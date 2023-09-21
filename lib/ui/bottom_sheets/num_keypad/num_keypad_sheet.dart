import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(210, 212, 217, 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '4',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '5',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '6',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '7',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '8',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '9',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor: Colors.white),
                    child: const Text(
                      '0',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: ElevatedButton(
                    onPressed: () => print('hi'),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 45),
                        backgroundColor:
                            const Color.fromRGBO(210, 212, 217, 1)),
                    child: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                  child: SizedBox(
                    height: 80,
                  ),
                ),
              ),
              Spacer()
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
