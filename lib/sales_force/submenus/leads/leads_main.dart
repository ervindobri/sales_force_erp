import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/global_variables.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/helpers/custom_dropdown.dart';
import 'package:sales_force_erp/models/lead.dart';
import 'package:sales_force_erp/sales_force/views/split_view.dart';
import 'package:sales_force_erp/tasks/kanban_view.dart';
import 'package:sales_force_erp/tasks/table_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SFLeads extends StatefulWidget {
  @override
  _SFLeadsState createState() => _SFLeadsState();
}

class _SFLeadsState extends State<SFLeads> with TickerProviderStateMixin{
    var controller;

  ScrollController _scrollController;

  int numItems;

  List<dynamic> _leadList = [];

  String _searchValue = "";

  var _currentView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    setState(() {
      _leadList = SalesForceGlobals.dummyLeads;
      _currentView = 2;
    });
    numItems = SalesForceGlobals.dummyLeads.length;
  }


  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3)
          ),
          child: Column(
            children: [
                //header
                Container(
                  height: 110,
                  width: _width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    boxShadow: [BoxShadow(
                      color: SalesForceGlobals.textColor.withOpacity(.2),
                      offset: Offset(0,2)
                    )]
                  ),
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                          Positioned(
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(
                                                        FontAwesomeIcons.male,
                                                        color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      child: AutoSizeText(
                                                        "Leads",
                                                        style: GoogleFonts.openSans(
                                                          fontSize: 10,
                                                          color: SalesForceGlobals.textColor
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      // color: Colors.black,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.all(0),
                                                            child: new DropdownButton<String>(
                                                              value: SalesForceGlobals.sortingCategoriesList.first,
                                                              iconSize: 16,
                                                              elevation: 0,
                                                              items: SalesForceGlobals.sortingCategoriesList.map((String value) {
                                                                return  DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child:  Text(
                                                                      value,
                                                                      style: GoogleFonts.openSans(
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w600
                                                                      ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged: (value) {

                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              ,
                                            ],
                                          ),
                                          Container(
                                            // color: Colors.black,
                                            child: Row(
                                              children: [
                                                AutoSizeText(
                                                  "$numItems items",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 10,
                                                      color: SalesForceGlobals.textColor
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.solidCircle,
                                                    size: 3,
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  "Sorted by Full Name",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 10,
                                                      color: SalesForceGlobals.textColor
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.solidCircle,
                                                    size: 3,
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  "Updated a few seconds ago",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 10,
                                                      color: SalesForceGlobals.textColor
                                                  ),
                                                )
                                                ,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ),
                            ),
                          ), // LEFT SIDE
                          Positioned(
                            right: 0 ,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: _width/2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
                                          borderRadius: BorderRadius.circular(3)
                                          ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            FlatButton(
                                                onPressed: () async {
                                                  print("new");
                                                  double dialogWidth = max(_width/3,600);
                                                  await showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) => new AlertDialog(
                                                        contentPadding: EdgeInsets.zero,
                                                    title: Center(
                                                      child: new Text(
                                                          'New Lead',
                                                        style: GoogleFonts.openSans(
                                                            color: SalesForceGlobals.textColor,
                                                          fontWeight: FontWeight.w100
                                                        ),
                                                      ),
                                                    ),
                                                    content: Container(
                                                      width: dialogWidth,
                                                      height: _height,
                                                      child: CupertinoScrollbar(
                                                        thickness: 10,
                                                        isAlwaysShown: true,
                                                        controller: _scrollController,
                                                        child: SingleChildScrollView(
                                                          controller: _scrollController,
                                                          child: Column(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    color: Colors.grey.shade100,
                                                                    width: dialogWidth,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'Lead Information'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: dialogWidth,
                                                                    height: 444,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'blabla'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    color: Colors.grey.shade100,
                                                                    width: dialogWidth,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'Address Information'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: dialogWidth,
                                                                    height: 444,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'blabla'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    color: Colors.grey.shade100,
                                                                    width: dialogWidth,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'Additional Information'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: dialogWidth,
                                                                    height: 444,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'blabla'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    color: Colors.grey.shade100,
                                                                    width: dialogWidth,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'Description Information'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: dialogWidth,
                                                                    height: 444,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                          'blabla'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context, rootNavigator: true)
                                                              .pop(); // dismisses only the dialog and returns nothing
                                                        },
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(3),
                                                          side: BorderSide(
                                                            color: SalesForceGlobals.textColor.withOpacity(.2),
                                                          )
                                                        ),
                                                        child: new Text(
                                                            'Cancel',
                                                          style: GoogleFonts.openSans(
                                                            color: SalesForceGlobals.blueColor
                                                          ),
                                                        ),
                                                      ),
                                                      new FlatButton(
                                                        onPressed: () {
                                                          //TODO
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(3),

                                                            side: BorderSide(
                                                                color: SalesForceGlobals.textColor.withOpacity(.2)
                                                            )
                                                        ),
                                                        color:Colors.white,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                                                          child: Text(
                                                              'Save & New',
                                                            style: GoogleFonts.openSans(
                                                                color: SalesForceGlobals.blueColor
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      new FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context, rootNavigator: true)
                                                              .pop(); // dismisses only the dialog and returns nothing
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(3),
                                                        ),
                                                        color: SalesForceGlobals.blueColor,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                                                          child: new Text(
                                                              'Save',
                                                            style: GoogleFonts.openSans(
                                                                color: Colors.white
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  );

                                                  },
                                                minWidth: 73,
                                                child: Center(
                                                  child: Text(
                                                    "New",
                                                    style: GoogleFonts.openSans(
                                                      color: SalesForceGlobals.blueColor,
                                                      fontWeight: FontWeight.w100
                                                    ),
                                                  ),
                                                ),

                                              ),
                                            SizedBox(
                                              height: 30,
                                              width: 2,
                                              child: VerticalDivider(
                                                color: SalesForceGlobals.textColor.withOpacity(.2),
                                                width: 1,
                                                thickness: 1,
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                print("import");
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Import",
                                                  style: GoogleFonts.openSans(
                                                      color: SalesForceGlobals.blueColor,
                                                      fontWeight: FontWeight.w100
                                                  ),
                                                ),
                                              ),


                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                              Container(
                                                width: 200,
                                                color: Colors.white,
                                                child: CupertinoTextField(
                                                  onSubmitted: (value){
                                                      setState(() {
                                                        _searchValue = value;
                                                        print(_searchValue);
                                                      });
                                                  },
                                                  onChanged: (value) {
                                                      if(value == ""){
                                                        setState(() {
                                                          _searchValue = "";
                                                          print(_searchValue);
                                                        });
                                                      }
                                                  },
                                                  placeholder: "Search ths list...",
                                                  cursorColor: Colors.black,
                                                  maxLines: 1,
                                                  clearButtonMode: OverlayVisibilityMode.editing,
                                                  controller: controller,
                                                  maxLength: 10,
                                                  prefix: Padding(
                                                    padding: const EdgeInsets.only(right: 2, left: 8),
                                                    child: Icon(
                                                      Icons.search,
                                                      size: 17,
                                                      color: SalesForceGlobals.textColor,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3),
                                                    border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2))
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: InkWell(
                                                onTap: () => print("settings"),
                                                child: Container(
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(3),
                                                      border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2))
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons.cog,
                                                          color: SalesForceGlobals.textColor,
                                                          size: 12,
                                                        ),
                                                        FaIcon(
                                                          FontAwesomeIcons.sortDown,
                                                          color: SalesForceGlobals.textColor,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                              Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: InkWell(
                                                onTap: () => print("filter"),
                                                child: Container(
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(3),
                                                      border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2))
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,

                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons.filter,
                                                          color: SalesForceGlobals.textColor,
                                                          size: 12,
                                                        ),
                                                        FaIcon(
                                                          FontAwesomeIcons.sortDown,
                                                          color: SalesForceGlobals.textColor,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                              switchViewDropDownMenu(),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: InkWell(
                                                  onTap: () => print("reload"),
                                                  child: Container(
                                                    width: 45,

                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(3),
                                                        border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2))
                                                    ),
                                                    child: Center(
                                                      child: FaIcon(
                                                          FontAwesomeIcons.redo,
                                                        color: SalesForceGlobals.textColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),// BUTTONS ON RIGHT
                      ],
                    ),
                  ),
                ),
                //contents

                //table with list
                Container(
                  height: _height - 200,
                  color: _currentView != 2 ? Colors.white : Colors.transparent,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInOut,
                    child: getCurrentView(),
                  ),
                ),
            ],
          ),
    );
  }





  //TODO: search in table
  getTableView() {
      if ( _searchValue == ""){
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              TableView(data: _leadList, headers: SalesForceGlobals.leadHeaders,),
            ],
          ),
        );
      }
      else{
          print("searching..");
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Text("Searching for $_searchValue"),
                TableView(data: SalesForceGlobals.dummyLeads.where((element) => element.subject.toLowerCase().contains(_searchValue.toLowerCase())).toList(), headers: SalesForceGlobals.leadHeaders,),
              ],
            ),
          );
      }
  }

  switchViewDropDownMenu() {
    return Padding(
      padding: const EdgeInsets.only(left:5.0),
      child: Center(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2))
          ),
          child: CustomDropDownMenu(
            title: "DISPLAY AS",
            hasIcon: true,
            icons: [
              Icon(
                FontAwesomeIcons.list,
                size: 12,
                color: SalesForceGlobals.textColor,
              ),
              Icon(
                Icons.drag_indicator_rounded,
                size: 12,
                color: SalesForceGlobals.textColor,
              ),
              Icon(
                FontAwesomeIcons.columns,
                size: 12,
                color: SalesForceGlobals.textColor,
              ),
            ],
            shadow: BoxShadow(
                color: SalesForceGlobals.textColor,
                blurRadius: 5.0,
                spreadRadius: 2,
                offset: Offset(0,3)
            ),
            widgets: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Table",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                      color: SalesForceGlobals.textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 12),
                    child: FaIcon(
                      FontAwesomeIcons.list,
                      size: 15,
                      color: SalesForceGlobals.textColor,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kanban",
                    textAlign: TextAlign.left,

                    style: GoogleFonts.openSans(
                      color: SalesForceGlobals.textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 12),
                    child: Icon(
                      Icons.drag_indicator_rounded,
                      size: 15,
                      color: SalesForceGlobals.textColor,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Split View",
                    textAlign: TextAlign.left,

                    style: GoogleFonts.openSans(
                      color: SalesForceGlobals.textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 12),
                    child: FaIcon(
                      FontAwesomeIcons.columns,
                      size: 15,
                      color: SalesForceGlobals.textColor,
                    ),
                  )
                ],
              ),
            ],
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(6),
            width: 150,
            offset: 50.25,
            onChange: (index) {
              setState(() {
                _currentView = index;
              });
            },
          ),
        ),
      ),
    );
  }

  getCurrentView() {
    Widget view;
    switch(_currentView){
      case 0:
        setState(() {
          view = AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            child: getTableView(),
          );
        });

        break;
      case 1:
        print(_searchValue);
        setState(() {
          view = KanbanView(
            data: SalesForceGlobals.dummyLeads.where((element) => element.subject.toLowerCase().contains(_searchValue.toLowerCase())).toList(),
            columns: 5,
            columnColor: Colors.white,
          );
        });

        break;
      case 2:
        view = SplitView(data: SalesForceGlobals.dummyLeads.where((element) => element.subject.toLowerCase().contains(_searchValue.toLowerCase())).toList(),);
        break;
    }
    return view;
  }

}
