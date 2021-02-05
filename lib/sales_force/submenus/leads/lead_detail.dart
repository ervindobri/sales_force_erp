import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/models/lead.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class LeadDetails extends StatefulWidget {
  final Lead lead;

  const LeadDetails({Key key, this.lead}) : super(key: key);
  @override
  _LeadDetailsState createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animationTween;


  TabController  _tabController;


   final List<String> detailMenu = ["Details","Marketing", "Notes & Files"];

  // TODO: define detail pages
   Widget getLeadDetails(String tab ){
     Widget view = Container();
    switch(tab){
      case "Details":
        view = Text(
          "1"
        );
        break;
      case "Marketing":
        view = Text(
            "2"
        );
        break;
      case "Notes & Files":
        view = Text(
            "3"
        );
        break;
    }
    return view;
  }
  
  
  
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: detailMenu.length); // 3 menus - details/ marketing/ notes & files
  }

  int _counter = 0;

  void _incrementStepper() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      decoration: BoxDecoration(
          // gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       SalesForceGlobals.salesForceColor,
          //       Colors.blueGrey.withOpacity(.5)
          //     ]
          // )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: _height/6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Container(
                      height: (_height/6)/2,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.star,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lead",
                                    style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: SalesForceGlobals.textColor
                                    ),
                                  ),
                                  AutoSizeText(
                                    "${widget.lead.subject}",
                                    maxLines: 1,
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        color: SalesForceGlobals.textColor,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Client",
                                      style: GoogleFonts.openSans(
                                          fontSize: 13,
                                          color: SalesForceGlobals.textColor
                                      ),
                                    ),
                                    Text(
                                      "${widget.lead?.client?.name ?? ""}",
                                      style: GoogleFonts.openSans(
                                          fontSize: 13,
                                          color: SalesForceGlobals.textColor
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Agent",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: SalesForceGlobals.textColor
                                    ),
                                  ),
                                  Text(
                                    "${widget.lead?.agent?.name ?? ""}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: SalesForceGlobals.textColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Phone",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: SalesForceGlobals.textColor
                                    ),
                                  ),
                                  Text(
                                    "${widget.lead.phoneNumber}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: SalesForceGlobals.textColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Email",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: SalesForceGlobals.textColor
                                    ),
                                  ),
                                  Text(
                                    "${widget.lead.email}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: SalesForceGlobals.textColor
                                    ),
                                  )
                                ],
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 60,
                width: _width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProgressStepper(
                      width: _width/2,
                      height: 30,
                      padding: 0,
                      stepCount: SalesForceGlobals.leadStatusList.length,
                      builder: (index) {
                        double widthOfStep = (_width/2) / SalesForceGlobals.leadStatusList.length;
                        if (index == 1) {
                          return ProgressStepWithArrow(
                            width: widthOfStep,
                            defaultColor: SalesForceGlobals.blueColor,
                            progressColor: SalesForceGlobals.greenColor,
                            wasCompleted: _counter >= index,
                            borderRadius: 25.0,
                          );
                        }
                        return ProgressStepWithChevron(
                          width: widthOfStep,
                          defaultColor: SalesForceGlobals.blueColor,
                          progressColor: SalesForceGlobals.greenColor,
                          wasCompleted: _counter >= index,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: FlatButton(
                        minWidth: 100,
                        color: SalesForceGlobals.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          _incrementStepper();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.check,
                                size: 10,
                              ),
                              Text(
                                "Mark Status as Complete",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: _height/2,
                width: _width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                            controller: _tabController,
                            labelColor: SalesForceGlobals.textColor,
                            unselectedLabelColor: SalesForceGlobals.textColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Colors.blueAccent,
                            indicatorPadding: EdgeInsets.all(0),
                            labelPadding:  EdgeInsets.only(left: 10, right: 10),
                            isScrollable: true,
                            indicator: MaterialIndicator(
                              height: 3,
                              color: SalesForceGlobals.salesForceColor,
                              horizontalPadding: 10.0,
                              tabPosition: TabPosition.bottom,
                              bottomLeftRadius: 0,
                              bottomRightRadius: 0,
                              topRightRadius: 0,
                              topLeftRadius: 0
                            ),
                            tabs: List.generate(detailMenu.length, (index) => Tab(
                              child: Container(
                                child: AutoSizeText(
                                  detailMenu[index],
                                  minFontSize: 15,
                                  maxFontSize: 20,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                              ,)
                        ),
                        Divider(
                          color: SalesForceGlobals.textColor.withOpacity(.4),
                          height: 1,
                          thickness: .5,
                        ),
                        Container(
                          height: _height/2.5,
                          width: _width,
                          child: TabBarView(
                              controller: _tabController,
                              children: List.generate(detailMenu.length, (index) => getLeadDetails(detailMenu[index])
                              )
                            ,)
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                widget.lead.subject
              ),
            ),
          ],
        ),
      ),
    );
  }
}
