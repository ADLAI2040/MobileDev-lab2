import 'package:flutter/material.dart';

class TerminalWidget extends StatefulWidget {
  List<String> items;
  String textFrom;
  String textIn;
  String defaultScaleFrom;
  String defaultScaleIn;
  final Function(String, bool) onScaleChanged;

  TerminalWidget({
    required this.textFrom,
    required this.textIn,
    required this.items,
    required this.defaultScaleFrom,
    required this.defaultScaleIn,
    required this.onScaleChanged,
  });
  @override
  State<TerminalWidget> createState() {
    return _TerminalState();
  }
}

class _TerminalState extends State<TerminalWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${widget.textFrom}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: widget.defaultScaleFrom,
                  onChanged: (String? newValueItemFrom) {
                    setState(() {
                      if (newValueItemFrom != null) {
                        widget.onScaleChanged(newValueItemFrom, true);
                      }
                    });
                  },
                  items: widget.items.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  dropdownColor: Colors.grey[100],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${widget.textIn}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: widget.defaultScaleIn,
                  onChanged: (String? newValueItemIn) {
                    setState(() {
                      if (newValueItemIn != null) {
                        widget.onScaleChanged(newValueItemIn, false);
                      }
                    });
                  },
                  items: widget.items.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  dropdownColor: Colors.grey[100],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
