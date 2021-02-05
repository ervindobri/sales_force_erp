import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/models/lead.dart';
import 'package:sales_force_erp/sales_force/submenus/leads/lead_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class SplitView extends StatefulWidget {
  final List<dynamic> data;

  const SplitView({Key key, this.data}) : super(key: key);
  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  Lead _currentLead;

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    super.initState();
    _currentLead = null;
  }
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      // height: _height,
      // width: _width,
      child: Row(
        children: [
          //list with leads
          //TODO: design
          Container(
            width: _width/4,
            height: _height,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.3))
            ),
            child: CupertinoScrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              thicknessWhileDragging: 12,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: getCurrentObjectList(_width),
                ),
              ),
            ),
          ),
          _currentLead == null
              ? Expanded(
                child: Container(
            width: _width,
            height: _height,
            color: Colors.white,
            child: Center(
                child: Text("nothing selected yet")
            ),
          ),
              )
              : Expanded(
                child: Container(
            width: _width,
            color: Colors.transparent,
            child: LeadDetails(lead: _currentLead,),
          ),
              )
          //current opened lead details

        ],
      ),
    );
  }
  getCurrentObjectList(double _width){
      List<Widget> list  = [];
      switch(widget.data.runtimeType.toString()){
        case 'List<Lead>':
          widget.data.forEach((element) {
            list.add(InkWell(
              onTap: () {
                setState(() {
                  _currentLead = element;
                });
              },
              child: Container(
                height: 80,
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.3))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        element.subject,
                        maxLines: 2,
                        style: GoogleFonts.openSans(
                          color: SalesForceGlobals.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                        ),
                      ),
                      AutoSizeText(
                          element.client.name,
                        style: GoogleFonts.openSans(
                            color: SalesForceGlobals.textColor,
                            fontWeight: FontWeight.w200,
                          fontSize: 13
                        ),
                      ),
                    ],
                  ),
                ),),
            ));
          });
          break;
      }
      return list;
  }
}
