import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TimeWidget extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  TimeWidget(
      {required this.initialTime, required this.onTimeSelected});

  @override
  TimeWidgetState createState() =>
      TimeWidgetState();
}

class TimeWidgetState extends State<TimeWidget> {
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          Container(
            color: CupertinoColors.systemGrey4.resolveFrom(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: Text('Selesai'),
                  onPressed: () {
                    Navigator.of(context).pop(TimeOfDay(
                        hour: _selectedHour, minute: _selectedMinute));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Jam',
                        style: TextStyle(
                          color: CupertinoColors.inactiveGray,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32.0,
                          scrollController: FixedExtentScrollController(
                              initialItem: _selectedHour),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedHour = index;
                            });
                            widget.onTimeSelected(TimeOfDay(
                                hour: _selectedHour, minute: _selectedMinute));
                          },
                          children: List<Widget>.generate(24, (int index) {
                            return Center(
                              child: Text(
                                index.toString().padLeft(2, '0'),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Menit',
                        style: TextStyle(
                          color: CupertinoColors.inactiveGray,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32.0,
                          scrollController: FixedExtentScrollController(
                              initialItem: _selectedMinute),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMinute = index;
                            });
                            widget.onTimeSelected(TimeOfDay(
                                hour: _selectedHour, minute: _selectedMinute));
                          },
                          children: List<Widget>.generate(60, (int index) {
                            return Center(
                              child: Text(
                                index.toString().padLeft(2, '0'),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}