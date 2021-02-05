import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/helpers/custom_dropdown.dart';
import 'package:sales_force_erp/models/lead.dart';
import 'package:sales_force_erp/sales_force/submenus/leads/lead_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadCard extends StatefulWidget {
  final Lead lead;

  const LeadCard({Key key, this.lead}) : super(key: key);
  @override
  _LeadCardState createState() => _LeadCardState();
}

class _LeadCardState extends State<LeadCard> with TickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> _animationTween;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 30),
      vsync: this,
    );
    _animationTween =
        Tween(begin: 0.0, end: 10.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onHover: (hover){
          if ( hover){
            _animationController.forward();
          }
          else{
            _animationController.reverse();
          }
        },
        child: Material(
          elevation: _animationTween.value,
          child: Container(
            height: 120,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => LeadDetails(lead: widget.lead)
                        )),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: AutoSizeText(
                            (widget.lead).subject,
                            minFontSize: 12,
                            maxFontSize: 16,
                            maxLines: 2,
                            style: GoogleFonts.openSans(
                              color: SalesForceGlobals.blueColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AutoSizeText(
                          (widget.lead).client.name,
                          minFontSize: 12,
                          maxFontSize: 16,
                          maxLines: 1,
                          style: GoogleFonts.openSans(
                            color: SalesForceGlobals.textColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: CustomDropDownMenu(
                        onChange: (value) {
                          switch(value){
                            case 0:
                              openEditLeadDialog(_width,_height);
                              break;
                            case 1:
                              openDeleteLeadDialog(_width,_height);
                              break;
                            case 2:
                              openChangeOwnerLeadDialog(_width,_height);
                              break;
                          }
                          },
                        hasIcon: false,
                        icons: [],
                        shadow: BoxShadow(
                          color: SalesForceGlobals.textColor,
                          blurRadius: 10.0,
                          spreadRadius: -2,
                          offset: Offset(0,3)
                        ),
                        borderRadius: BorderRadius.circular(6),
                        width: 150,
                        backgroundColor: Colors.white,
                        widgets: [
                          InkWell(
                            hoverColor: Colors.grey.shade100,
                              // onTap: () => openEditLeadDialog(_width,_height),
                              child: Container(
                                  child: Text("Edit"))),
                          InkWell(
                              hoverColor: Colors.grey.shade100,
                              // onTap: openDeleteLeadDialog,
                              child: Container(
                                  child: Text("Delete"))),
                          InkWell(
                              hoverColor: Colors.grey.shade100,
                              // onTap: openChangeOwnerLeadDialog,
                              child: Container(
                                  child: Text("Change Owner")))
                        ],

                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openEditLeadDialog(double _width, double _height) async {
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
        width: _width,
        height: _height,
        // child: CupertinoScrollbar(
        //   thickness: 10,
        //   isAlwaysShown: true,
        //   controller: _scrollController,
        //   child: SingleChildScrollView(
        //     controller: _scrollController,
        //     child: Column(
        //       children: [
        //         Column(
        //           children: [
        //             Container(
        //               color: Colors.grey.shade100,
        //               width: dialogWidth,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'Lead Information'),
        //               ),
        //             ),
        //             Container(
        //               width: dialogWidth,
        //               height: 444,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'blabla'),
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Container(
        //               color: Colors.grey.shade100,
        //               width: dialogWidth,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'Address Information'),
        //               ),
        //             ),
        //             Container(
        //               width: dialogWidth,
        //               height: 444,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'blabla'),
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Container(
        //               color: Colors.grey.shade100,
        //               width: dialogWidth,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'Additional Information'),
        //               ),
        //             ),
        //             Container(
        //               width: dialogWidth,
        //               height: 444,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'blabla'),
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Container(
        //               color: Colors.grey.shade100,
        //               width: dialogWidth,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'Description Information'),
        //               ),
        //             ),
        //             Container(
        //               width: dialogWidth,
        //               height: 444,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                     'blabla'),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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
  }

  void openChangeOwnerLeadDialog(double _width, double _height) {
  }

  void openDeleteLeadDialog(double _width, double _height) {
  }
}
