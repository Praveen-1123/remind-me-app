import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/helpers/toast.dart';
import 'package:remind_me/models/time_period.dart';
import 'package:remind_me/views/bottom_sheets/date_time.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key key}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController _title = new TextEditingController();
  TextEditingController _description = new TextEditingController();

  DateTime now = DateTime.now();

  List<TimePeriod> _periods = List<TimePeriod>.empty(growable: true);

  @override
  void initState() {
    validatePeriod();
    super.initState();
  }

  void validatePeriod() async {
    int hour = TimeOfDay.now().hour;
    _periods.add(new TimePeriod(
        "Morning",
        DateTime(now.year, now.month, now.day, 9, 0),
        hour > 9 ? false : true,
        false));
    _periods.add(new TimePeriod(
        "AfterNoon",
        DateTime(now.year, now.month, now.day, 13, 0),
        hour > 13 ? false : true,
        false));
    _periods.add(new TimePeriod(
        "Evening",
        DateTime(now.year, now.month, now.day, 17, 0),
        hour > 17 ? false : true,
        false));
    _periods.add(new TimePeriod(
        "Night",
        DateTime(now.year, now.month, now.day, 20, 0),
        hour > 20 ? false : true,
        false));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            size: 30,
            color: theme.focusColor,
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () async {
                DateTime data = await showDateTimePicker(context);
                print(data);
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                  color: theme.textTheme.headline1.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                "Create new task",
                style: TextStyle(
                    fontSize: 25,
                    color: theme.textTheme.headline1.color,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.textTheme.bodyText1.color,
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: theme.focusColor.withOpacity(0.5),
                          width: 0.35,
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _title,
                      cursorColor: theme.textTheme.headline1.color,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: theme.textTheme.headline1.color,
                        hintText: '',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      maxLength: 40,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.textTheme.bodyText1.color,
                    ),
                  ),
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: theme.focusColor.withOpacity(0.5),
                          width: 0.35,
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _description,
                      cursorColor: theme.textTheme.headline1.color,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: theme.textTheme.headline1.color,
                        hintText: '',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose your time period",
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.textTheme.bodyText1.color,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Current Date is: ",
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.headline1.color,
                        ),
                      ),
                      Text(
                        "${DateFormat.yMMMd().format(DateTime.now()).toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(top: 7),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _periods.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              splashColor: theme.splashColor,
                              onTap: () {
                                _periods[index].isAvailable
                                    ? setState(() {
                                        _periods.forEach(
                                          (gender) => gender.isSelected = false,
                                        );
                                        _periods[index].isSelected = true;
                                      })
                                    : ToastMessage.toast("Not available");
                              },
                              child: Card(
                                color: _periods[index].isSelected
                                    ? theme.focusColor
                                    : theme.backgroundColor.withOpacity(0.75),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.5),
                                ),
                                child: Container(
                                  height: 27,
                                  width:
                                      MediaQuery.of(context).size.width / 5.2,
                                  alignment: Alignment.center,
                                  margin: new EdgeInsets.all(5.0),
                                  child: Text(
                                    _periods[index].name,
                                    style: TextStyle(
                                      color: _periods[index].isSelected
                                          ? theme.textTheme.headline2.color
                                          : theme.textTheme.bodyText1.color,
                                      decoration: _periods[index].isAvailable
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm()
                                  .format(_periods[index].dateTime)
                                  .toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: theme.textTheme.bodyText1.color,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
