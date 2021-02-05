import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/constants/theme_data.dart';
import 'package:sales_force_erp/models/lead.dart';
import 'package:sales_force_erp/models/order.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_animations/simple_animations.dart';

class TableView extends StatefulWidget {
  final List<dynamic> data;
  final List<DatatableHeader> headers;

  const TableView({Key key, this.data, this.headers}) : super(key: key);
  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView>  {
  static const Color blue = Color(0xff0052cc);

  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int _currentPerPage;
  int firstStartIndex = 0;
  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  String _selectableKey = "id";

  String _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

  var lastStartIndex = 5;

  int _maxPage;

  List<Map<String, dynamic>> _list = [];




  List<Map<String, dynamic>> _loadData() {
    final List source = widget.data;
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    // print(widget.data.runtimeType.toString());
    switch(widget.data.runtimeType.toString()) {
      case "List<Order>":
        for (Order data in source) {
          temps.add({
            "id": data.id,
            "date": data.date,
            "client": data.client,
            "agent": data.agent,
            "total": data.total,
            "currency": data.currency,
            "shipped": data.shipped,
            "invoiced": data.invoiced,
          });
        }
        break;
      case "List<Lead>":
        print("got some leads");
        for (Lead data in source) {
          temps.add({
            "id": data.id,
            "date": data.dateCreated,
            "subject": data.subject,
            "contact": data.contactName,
            "email": data.email,
            "phone": data.phoneNumber,
            "status": data.getStatusLabel(),
            "agent": data.agent != null ? data.agent.name :  "",
            "priority": data.getPriority(),
          });
        }
        break;
    }
    return temps;
  }

  _initData() async {
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 1)).then((value) {
      _source.addAll(_loadData()); //1000
      setState(() => _isLoading = false);
      _total = _source.length;
      _currentPerPage = _perPages.first;
      firstStartIndex = 0;
      lastStartIndex = _currentPerPage < _total ? _currentPerPage : _total;
      _maxPage = (_total / _currentPerPage) as int;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();

    print("Last:$lastStartIndex");
  }
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    if ( !_isLoading){
      _list = _source.getRange(firstStartIndex, lastStartIndex).toList();
    }
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(0),
        width: _width,
        height: _height/2,
        constraints: BoxConstraints(
          maxHeight: 700,
        ),
        child: !_isLoading ?
        Card(
            elevation: 1,
            shadowColor: Colors.black,
            clipBehavior: Clip.none,
            child:
            ResponsiveDatatable(
              title: Container(),
              titleStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.w600
              ),
              actions: null,
              headers: widget.headers,
              source: _source.getRange(firstStartIndex, lastStartIndex).toList(),
              selecteds: _selecteds,
              showSelect: _showSelect,
              autoHeight: false,
              rowHeight: 30, //TODO: find optimal rowheight/ set text+icon sizes accordingly
              rowFontSize: 12,
              checkColor: SalesForceGlobals.blueColor,
              onTabRow: (data) {
                print(data is Lead);
                //TODO: open details screen
              },
              onSort: (value) {
                setState(() {
                  _sortColumn = value;
                  _sortAscending = !_sortAscending;
                  if (_sortAscending) {
                    if (_source[0]["$_sortColumn"] is Client || _source[0]["$_sortColumn"] is Agent){
                      _source.sort((a, b) => b["$_sortColumn"].name
                          .compareTo(a["$_sortColumn"].name));
                    }
                    else if (_source[0]["$_sortColumn"] is List) {
                      _source.sort((a, b) => b["$_sortColumn"][0]
                          .compareTo(a["$_sortColumn"][0]));
                    } else {
                      _source.sort((a, b) => b["$_sortColumn"]
                          .compareTo(a["$_sortColumn"]));
                    }
                  }
                  else {
                    if (_source[0]["$_sortColumn"] is Client || _source[0]["$_sortColumn"] is Agent){
                      _source.sort((a, b) => a["$_sortColumn"].name
                          .compareTo(b["$_sortColumn"].name));
                    }
                    else if (_source[0]["$_sortColumn"] is List) {
                      _source.sort((a, b) => a["$_sortColumn"][0]
                          .compareTo(b["$_sortColumn"][0]));
                    } else {
                      _source.sort((a, b) => a["$_sortColumn"]
                          .compareTo(b["$_sortColumn"]));
                    }
                  }
                });
              },
              sortAscending: _sortAscending,
              sortColumn: _sortColumn,
              isLoading: _isLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => _selecteds.add(item));
                } else {
                  setState(() =>
                      _selecteds.removeAt(_selecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => _selecteds =
                      _source.map((entry) => entry).toList().cast());
                } else {
                  setState(() => _selecteds.clear());
                }
              },
              footers: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Rows per page:"),
                ),
                if (_perPages != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton(
                        value: _currentPerPage,
                        items: _perPages
                            .map((e) => DropdownMenuItem(
                          child: Text("$e"),
                          value: e,
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _currentPerPage = value;
                          });
                        }),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      "${firstStartIndex+1} - ${lastStartIndex} of $_total"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: () {
                    if ( _currentPage > 1){
                      setState(() {
                        lastStartIndex = _currentPage >= 2 ? lastStartIndex - _currentPerPage : _currentPerPage;
                        firstStartIndex =  _currentPage >= 2 ? firstStartIndex - _currentPerPage : 1;
                        _currentPage--;
                      });
                      print(_currentPage);
                    }

                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    if ( _currentPage < _total/_currentPerPage){
                      setState(() {
                        _currentPage++;
                        lastStartIndex = _currentPage >= 2 ? lastStartIndex + _currentPerPage : _currentPerPage;
                        firstStartIndex =  _currentPage >= 2 ? firstStartIndex + _currentPerPage : 1;
                      });
                      print(_currentPage);

                    }

                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                )
              ],
            )
        ):
          Center(
            child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.erondGreen),
              ),
            ),
          ));
  }
}
