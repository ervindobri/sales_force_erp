import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/global_variables.dart';
import 'package:sales_force_erp/constants/theme_data.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CardView extends StatefulWidget {
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: min(width * .8, 1200),
        height: height,
        child: AnimationLimiter(
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: GlobalVariables.dummyOrders.length,
            itemBuilder: (BuildContext context, int index) =>
                AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: Duration(milliseconds: 500+(index*100)),
                  columnCount: 4,
                  child: SlideAnimation(
                    verticalOffset: -20,
                    child: FadeInAnimation(
                      child: InkWell(
                        onTap: () => print("kecske"),
                        onHover: (hovered) => null,
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black.withOpacity(.15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                                color: Colors.white,
                                height: 150,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            '${GlobalVariables.dummyOrders[index].client.name}',
                                            maxLines: 3,
                                            maxFontSize: 20,
                                            minFontSize: 16,
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.lato(
                                                color: ThemeColors.almostBlack,
                                                // fontSize: 25,
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Text(
                                              '${GlobalVariables.dummyOrders[index].agent.name}',
                                              style: GoogleFonts.lato(
                                                  color: ThemeColors.almostBlack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${GlobalVariables.dummyOrders[index].total} ${GlobalVariables.dummyOrders[index].currency}",
                                                style: GoogleFonts.lato(
                                                    color: Colors.redAccent,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.w900
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    "${GlobalVariables.dummyOrders[index].invoiced ? "Invoiced" : ""}",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.redAccent,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w300
                                                    ),
                                                  ),
                                                  Text(
                                                    "${GlobalVariables.dummyOrders[index].shipped ? "Shipped" : ""}",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.redAccent,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w300
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: (GlobalVariables.dummyOrders[index].getStatusLabel()[1]).withOpacity(0.2),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    GlobalVariables.dummyOrders[index].getStatusLabel()[0],
                                                    style: GoogleFonts.lato(
                                                        color: (GlobalVariables.dummyOrders[index].getStatusLabel()[1]).withOpacity(1),

                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: FaIcon(
                                                    GlobalVariables.dummyOrders[index].getStatusLabel()[2],
                                                    color: (GlobalVariables.dummyOrders[index].getStatusLabel()[1]).withOpacity(1),

                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(1, 1.2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ),
    );
  }
}
