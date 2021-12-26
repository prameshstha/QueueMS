import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:queuems/utility/constant.dart';

class SelectDateWidget extends StatelessWidget {
  final ValueChanged<String> dateSelect;
  final String datess;
  const SelectDateWidget({
    Key? key,
    required this.dateSelect,
    required this.datess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //container for icon
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(255, 240, 240, 1),
          ),
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.calendar_today,
            color: Colors.redAccent,
          ),
        ),
        //for spacing
        const SizedBox(
          width: 24,
        ),

        //for text
        TextButton(
            onPressed: () {
              selectDate(context);
            },
            child: Text(datess.isEmpty ? 'Select Date' : datess,
                style: TextStyle(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700]))),
      ],
    );
  }

  void selectDate(
    BuildContext context,
  ) {
    DateFormat Dateformatter = DateFormat('yyyy-MM-dd');
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // firstDate: DateTime(2019, 1),
        // lastDate: DateTime(2030, 12),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime.now().add(Duration(days: 14)),
        builder: (context, picker) {
          return Theme(
            //change colors
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: kprimaryColor,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        // (selectedDate.year+selectedDate.month+selectedDate.day)
        var formattedDate = Dateformatter.format(selectedDate);
        dateSelect(formattedDate);
      }
    });
  }
}
