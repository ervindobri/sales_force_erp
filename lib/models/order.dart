import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/theme_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Client{
  String id;
  String name;

  Client(this.id, this.name);
}

class Agent{
  static String id;
  String name;

  Agent({this.name});
}

enum Currency{
  RON, EUR, HUF, USD
}

enum OrderState{
  ACTIVE, INACTIVE, CLOSED, DELETED
}

class Order{
  String id;
  String date;
  Agent agent;
  Client client;
  double total;
  // Currency currency;
  String currency;
  String state;
  bool shipped;
  bool invoiced;

  Order(
    this.id,
    this.agent,
    this.client,
      [
    this.date = "01.01.2021",
    this.total = 22.69,
    this.currency = "RON",
    this.state = "inactive",
    this.shipped = false,
    this.invoiced = false]
      );

  getStatusLabel(){
    List<dynamic> stuff = [];
    switch(this.state){
      case "done":
        stuff = ["Done", ThemeColors.erondGreen, FontAwesomeIcons.checkDouble];
        break;
      case "progress":
        stuff = ["In Progress", Colors.blue, FontAwesomeIcons.spinner];
        break;
      case "cancel":
        stuff = ["Canceled", Colors.grey, FontAwesomeIcons.ban];

    }
    return stuff;
  }
}