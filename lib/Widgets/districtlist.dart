import 'package:corona_app/Widgets/vaccinedata.dart';
import 'package:corona_app/globals.dart' as g;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Selection extends StatefulWidget {
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  TextEditingController inputController = TextEditingController();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  var _onSearch;
  bool isEnabled = false;
  bool isVisible = false;
  final _controller = ScrollController();

  @override
  void initState() {
    g.selectedDate = formatter.format(DateTime.now()).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isEnabled) {
      _onSearch = () {
        setState(() {
          isVisible = true;
          // Get the height you want to scroll to.
          final screenHeight = MediaQuery.of(context).size.height;

          // Adding Animation to scroll down
          _controller.animateTo(screenHeight,
              curve: Curves.easeOut, duration: Duration(seconds: 1));
        });
      };
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vaccination Slot Information",
          style: TextStyle(
            fontFamily: 'MPLUSRounded',
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: 15, top: 15),
              child: Text(
                'Search By District',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  fontFamily: 'MPLUSRounded',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.1),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'MPLUSRounded',
                          ),
                          hint: Text(
                            g.selectedState,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'MPLUSRounded',
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              g.selectedState = 'Select State';
                              g.selectedDistrict = 'Select District';
                            });
                          },
                          onChanged: (newValue) {
                            setState(() {
                              g.selectedState = newValue ?? "";
                              g.districtList = [];
                              g.selectedDistrict = 'Select District';
                              isEnabled = false;
                              _getDistrictList();
                            });
                          },
                          items: g.states.map((item) {
                            return DropdownMenuItem(
                              child: new Text(item),
                              value: item.toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.1),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'MPLUSRounded',
                          ),
                          hint: Text(
                            g.selectedDistrict,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'MPLUSRounded',
                            ),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              g.selectedDistrict = newValue ?? "";
                              isEnabled = true;
                            });
                          },
                          items: g.districtList.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item),
                              value: item.toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                      fontFamily: 'MPLUSRounded',
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent[100],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Search By PIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                    fontFamily: 'MPLUSRounded',
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (pin) {
                        setState(() {
                          g.enteredPin = pin;
                          isEnabled = false;
                          if (pin.length > 5) {
                            isEnabled = true;
                          }
                        });
                      },
                      style: TextStyle(
                        fontFamily: 'MPLUSRounded',
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: inputController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'MPLUSRounded',
                        ),
                        focusColor: Colors.blue[900],
                        label: Text(
                          "Enter PIN",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'MPLUSRounded',
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      cursorColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'MPLUSRounded',
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black,
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025))
                            .then((date) {
                          setState(() {
                            if (date != null) {
                              g.selectedDate =
                                  formatter.format(date).toString();
                            } else {
                              g.selectedDate = g.selectedDate;
                            }
                          });
                        });
                      },
                      decoration: InputDecoration(
                        hintText: g.selectedDate,
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'MPLUSRounded',
                        ),
                        focusColor: Colors.blue[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontFamily: 'MPLUSRounded',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 25),
                        primary: Colors.blue[900],
                        shadowColor: Colors.blue[900],
                        padding: EdgeInsets.symmetric(vertical: 7.5),
                      ),
                      onPressed: _onSearch,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: isVisible,
              child: CentreList(),
            )
          ],
        ),
      ),
    );
  }

  String _getDistrictList() {
    setState(() {
      g.statedistdata[g.selectedState]?.forEach((key, value) {
        g.districtList.add(key);
      });
    });

    return "";
  }
}
