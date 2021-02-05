import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SalesForceErond extends StatefulWidget {
  @override
  _SalesForceErondState createState() => _SalesForceErondState();
}

class _SalesForceErondState extends State<SalesForceErond> with TickerProviderStateMixin{
  TabController  _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: SalesForceGlobals.mainMenu.length);
  }
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only( left: 30.0,top: 15.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.th,
                                color: SalesForceGlobals.textColor,
                                size: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                SalesForceGlobals.salesLabel,
                                style: GoogleFonts.openSans(
                                  color: SalesForceGlobals.textColor
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: min(60, _height/10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.2)
                      )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                        width: _width*.6,
                        color: Colors.transparent,
                        child: TabBar(
                            controller: _tabController,
                            labelColor: SalesForceGlobals.textColor,
                            unselectedLabelColor: SalesForceGlobals.textColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.blueAccent,
                            indicatorPadding: EdgeInsets.all(1),
                            labelPadding:  EdgeInsets.only(left: 7, right: 7),
                            isScrollable: true,
                            indicator: MaterialIndicator(
                              height: 3,
                              color: SalesForceGlobals.salesForceColor,
                              topLeftRadius: 5,
                              horizontalPadding: 0.0,
                              topRightRadius: 5,
                              bottomLeftRadius: 5,
                              bottomRightRadius: 5,
                              tabPosition: TabPosition.top,
                            ),
                            tabs: List.generate(SalesForceGlobals.mainMenu.keys.length, (index) => Tab(
                              child: Container(
                                child: AutoSizeText(
                                    SalesForceGlobals.mainMenu.keys.toList()[index],
                                  minFontSize: 12,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12
                                  ),
                                ),
                              ),
                            )
                              ,)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: _width/3.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          FaIcon(
                          FontAwesomeIcons.solidBell,
                          color: SalesForceGlobals.textColor,
                          size: 15,
                        ),
                          RawMaterialButton(
                            splashColor: Colors.blueAccent.withOpacity(.3),
                            onPressed: () => print("profile"),
                            shape: CircleBorder(),
                            child: FaIcon(
                              FontAwesomeIcons.userCircle,
                              color: SalesForceGlobals.salesForceColor,
                            ),
                          )
                        ]
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: _height - min(60, _height/10),
                width: _width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter, 
                      colors: [
                        SalesForceGlobals.salesForceColor,
                        Colors.blueGrey.withOpacity(.5)
                      ]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: Container(
                    width: _width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(SalesForceGlobals.mainMenu.values.length, (index) => SalesForceGlobals.mainMenu.values.toList()[index],)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
