import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showDateTimePicker(BuildContext context) async {
  DateTime date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      color: Theme.of(context).cardColor,
      height: 300,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).cardColor,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                date = newDateTime;
              },
              minimumYear: 2022,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context, date);
              },
              child: Text(
                "Done",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.headline1.color,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
