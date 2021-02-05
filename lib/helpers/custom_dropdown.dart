import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomDropDownMenu extends StatefulWidget {
  @required final String title;
  @required final List<Icon> icons;
  @required final List<Widget> widgets;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final double offset;
  final Color iconColor;
  final ValueChanged<int> onChange;
  final Icon mainIcon;
  final double width;

  final bool hasIcon;
  final BoxShadow shadow;

  const   CustomDropDownMenu({
    Key key,
    this.icons,
    this.borderRadius,
    this.backgroundColor = const Color(0xFFF67C0B9),
    this.iconColor = Colors.black,
    this.onChange,
    this.title,
    this.width,
    this.widgets,
    this.offset = 0.0,
    this.mainIcon,
    this.hasIcon, this.shadow,
  })  : assert(widgets != null),
        super(key: key);
  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> with SingleTickerProviderStateMixin {
  GlobalKey _key;
  bool isMenuOpen = false;
  Offset buttonPosition;
  Size buttonSize;
  OverlayEntry _overlayEntry;
  BorderRadius _borderRadius;
  AnimationController _animationController;

  Icon _mainIcon;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
    _key = LabeledGlobalKey("button_icon");
    _mainIcon = Icon(
      FontAwesomeIcons.list,
      size: 12,
      color: SalesForceGlobals.textColor,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: _borderRadius,
      ),
      child: IconButton(
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if ( widget.hasIcon ) _mainIcon,
            Padding(
              padding: EdgeInsets.only(left: widget.hasIcon ? 3.0 : 0.0),
              child: FaIcon(
                FontAwesomeIcons.sortDown,
                color: SalesForceGlobals.textColor,
                size: 12,
              ),
            )
          ],
        ),
        color: widget.iconColor,
        onPressed: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx - widget.offset,
          // width: buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      height: (widget.widgets.length+1) * buttonSize.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius: _borderRadius,
                        boxShadow: [widget.shadow]
                      ),
                      child: Theme(
                        data: ThemeData(
                          iconTheme: IconThemeData(
                            color: widget.iconColor,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if ( widget.title != null ) Text(
                              widget.title,
                              style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: SalesForceGlobals.textColor,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(widget.widgets.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    widget.onChange(index);
                                    if ( widget.icons != null && widget.icons.isNotEmpty){
                                      setState(() {
                                        _mainIcon = widget.icons[index];
                                      });
                                    }
                                    closeMenu();
                                  },
                                  hoverColor: Colors.grey.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Container(
                                      width: widget.width,
                                      height: buttonSize.height,
                                      child: widget.widgets[index],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}