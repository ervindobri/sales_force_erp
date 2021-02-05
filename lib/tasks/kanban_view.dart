import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/sales_force/submenus/leads/lead_card.dart';
import 'package:google_fonts/google_fonts.dart';

class KanbanView extends StatefulWidget {
  final List<dynamic> data;
  final int columns;
  final Color columnColor;

  const KanbanView({Key key, this.data, this.columns, this.columnColor}) : super(key: key);
  @override
  _KanbanViewState createState() => _KanbanViewState();
}

class _KanbanViewState extends State<KanbanView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data.length);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    //ERP ORDERS
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Row(
          children: List.generate(SalesForceGlobals.leadColumnNames.length, (index) {
            int nrLeads = widget.data.where((element) => element.status == SalesForceGlobals.leadColumnNames[index].last).toList().length;
            return Expanded(
              child: Container(
                width: width/SalesForceGlobals.leadColumnNames.length,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: SalesForceGlobals.textColor.withOpacity(.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height:40,
                      width: width/SalesForceGlobals.leadColumnNames.length,
                      decoration: BoxDecoration(
                          color: SalesForceGlobals.blueColor,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: AutoSizeText(
                          "${SalesForceGlobals.leadColumnNames[index].first}   ($nrLeads)",
                          maxLines: 1,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(widget.data.where((element) => element.status == SalesForceGlobals.leadColumnNames[index].last).toList().length,
                                  (lindex) => LeadCard(lead: widget.data.where((element) => element.status == SalesForceGlobals.leadColumnNames[index].last).toList()[lindex]),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            );
          }

          ),
        )
      ),
    );
  }
}
