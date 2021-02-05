import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/constants/sales_force_copy.dart';
import 'package:sales_force_erp/models/order.dart';
import 'package:sales_force_erp/models/task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LeadStatus{
  New,
  Contacted,
  Working,
  Unqualified,
  Converted
}

enum Category{
  DERMATO,
}

enum Salutation{
  MR, MS, MRS, DR, PROF
}


class Lead{
  int id;
  String dateCreated;
  String subject;
  // String companyName;
  Client client;
  String address; //can be optimized
  Agent agent;
  String contactName;
  Salutation salutation; //mr.,ms. etc.

  String function; //functie?
  String email;
  String phoneNumber;
  LeadStatus status;
  Priority priority;
  Category category;

  Lead({
      this.id,
      this.subject,
      this.client,
      this.address = "Back Street, nr.22",
      this.agent,
      this.contactName = "John Doe",
      this.salutation = Salutation.MR,
      this.function = "function",
      this.email = "john.doe@example.com",
      this.phoneNumber = "063443298654",
      this.dateCreated = "2021-01-01-14.15",
      this.status = LeadStatus.New,
      this.priority = Priority.MEDIUM,
      this.category = Category.DERMATO
  }
      );


  @override
  String toString() {
    return 'Lead{id: $id, dateCreated: $dateCreated, subject: $subject, client: $client, address: $address, agent: $agent, contactName: $contactName, salutation: $salutation, function: $function, email: $email, phoneNumber: $phoneNumber, status: $status, priority: $priority, category: $category}';
  }

  getPriority() {
    IconData icon = FontAwesomeIcons.arrowUp;
    var iconColor = null;
    String label = "Low";
    switch(this.priority){
      case Priority.VERY_LOW:
        icon = FontAwesomeIcons.arrowDown;
        label = "Very Low";
        iconColor = Colors.greenAccent;
        break;
      case Priority.LOW:
        icon = FontAwesomeIcons.arrowDown;
        label = "Low";
        iconColor = Colors.green;
        break;
      case Priority.MEDIUM:
        icon = FontAwesomeIcons.arrowUp;
        label = "Medium";
        iconColor = Colors.orange;
        break;
      case Priority.HIGH:
        icon = FontAwesomeIcons.arrowUp;
        label = "High";
        iconColor = Colors.red;
        break;
      case Priority.VERY_HIGH:
        icon = FontAwesomeIcons.arrowUp;
        label = "Very High";
        iconColor = Colors.redAccent;
        break;
    }
    return [label, icon, iconColor];
  }
  getStatusLabel() {
    IconData icon = FontAwesomeIcons.checkCircle;
    var labelColor;
    String label = "New";
    switch(this.status){
      case LeadStatus.New:
        label = "New";
        icon = FontAwesomeIcons.plus;
        labelColor = SalesForceGlobals.blueColor;
        break;
    }
    return [label, labelColor, icon];
  }
}