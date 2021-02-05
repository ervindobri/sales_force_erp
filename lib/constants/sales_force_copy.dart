

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_force_erp/helpers/custom_dropdown.dart';
import 'package:sales_force_erp/models/lead.dart';
import 'package:sales_force_erp/models/order.dart';
import 'package:sales_force_erp/models/task.dart';
import 'package:sales_force_erp/sales_force/submenus/leads/leads_main.dart';
import 'package:sales_force_erp/tasks/kanban_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_table/DatatableHeader.dart';

class SalesForceGlobals{
    static final String salesLabel = "Sales";
    static final Map<String, dynamic> mainMenu = {
        "Home" : KanbanView(
    data: SalesForceGlobals.dummyLeads,
    columns: 5,
    columnColor: Colors.white,
    ),
        "Leads" : SFLeads(),
        "Accounts" : Container(),
        "Contacts" : Container(),
        "Opportunities" : Container(),
        "Cases" : Container(),
        "Tasks" : Container(),
        "Reports" : Container(),
        "Dashboards" : Container(),
        "List Emails" : Container()
};
    static final List<String> leadStatusList = ["New","Contacted", "Working", "Unqualified", "Converted"];
    static final textColor = const Color(0xff7a7a7a);
    static final salesForceColor = const Color(0xff0092da);
    static final blueColor = const Color(0xff005fb2);
    static final greenColor = const Color(0xff4bca81);

  static var sortingCategoriesList = ["All Open Leads","Lost Leads","My Unread Leads","Recently Viewed", "Today's Leads"];

  static List<Lead> dummyLeads = [
      Lead(id: 1, client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"), dateCreated: "25.07.2018 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "0251502184", status: LeadStatus.New, agent: Agent(name: "Inta Ferenc"), address: "Str. Tabaci, nr.1, Craiova, Dolj, 200642, Romania"),
      Lead(id: 2,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"), dateCreated: "25.07.2018 13:46:52", subject: "blabla", contactName: "", email: "john.doe@gmail.com", phoneNumber: "0251502165484", status: LeadStatus.Converted, priority: Priority.HIGH),
      Lead(id: 3,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.07.2021 13:46:52", subject: "b lalalads", contactName: "", email: "KFT@gmail.com", phoneNumber: "69", status: LeadStatus.Contacted, priority: Priority.VERY_HIGH),
      Lead(id: 4,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "08.07.2020 13:46:52", subject: "bulasdsadas", contactName: "", email: "bananjoe@gmail.com", phoneNumber: "07432939428", status: LeadStatus.Unqualified, priority: Priority.LOW),
      Lead(id: 5,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2019 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "222", status: LeadStatus.Working, priority: Priority.VERY_LOW),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.Working, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.Working, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.Working, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
    Lead(id: 6,client: Client("0", "Spit. Cl. Jud. de Urg. Craiova - 5002142"),dateCreated: "25.06.2016 13:46:52", subject: "Spitalul Clinic Judetean de Urgenta Craiova", contactName: "", email: "scjuc.tehnic@gmail.com", phoneNumber: "112", status: LeadStatus.New, ),
  ];

    static List<DatatableHeader> leadHeaders = [
        DatatableHeader(
            text: "ID",
            value: "id",
            show: false,
            sortable: true,
            textAlign: TextAlign.right), //id
        DatatableHeader(
            text: "Date",
            value: "date",
            show: true,
            flex: 1,
            sortable: true,
            editable: false,
            textAlign: TextAlign.left), //date
        DatatableHeader(
            text: "Subject",
            value: "subject",
            show: true,
            flex: 2,
            sortable: true,
            textAlign: TextAlign.left), //subject
        DatatableHeader(
            text: "Contact Name",
            value: "contact",
            show: true,
            sortable: true,
            textAlign: TextAlign.left),
        DatatableHeader(
            text: "Email",
            value: "email",
            show: true,
            sortable: true,
            textAlign: TextAlign.left),
        DatatableHeader(
            text: "Phone number",
            value: "phone",
            show: true,
            sortable: true,
            textAlign: TextAlign.left),
        DatatableHeader(
            text: "Status",
            value: "status",
            show: true,
            sortable: true,
            sourceBuilder: (value, row){
              List list = List.from(value);
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    list.first,
                    style: GoogleFonts.lato(
                        color: list[1],
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              );
            },
            textAlign: TextAlign.left),
        DatatableHeader(
            text: "Agent",
            value: "agent",
            show: true,
            sortable: true,
            sourceBuilder: (value, row) {
                if ( value is Agent){
                  Agent agent = value;
                  return Text(
                    agent.name,
                  );
                }
                return Text(value);
            },
            textAlign: TextAlign.left),
        DatatableHeader(
            text: "Priority",
            value: "priority",
            show: true,
            sortable: false,
            sourceBuilder: (value, row) {
                List list = List.from(value);
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(
                                        list[1],
                                        color: list.last,
                                      size: 12,
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${list.first}",
                                        style: GoogleFonts.lato(
                                            color: Colors.black
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                );
            },
            textAlign: TextAlign.left),
    ];

    static Map<int,dynamic> leadColumnNames = {
      0 : ["New", LeadStatus.New],
      1 : ["Contacted", LeadStatus.Contacted],
      2 : ["Working", LeadStatus.Working],
      3 : ["Unqualified", LeadStatus.Unqualified],
      4 : ["Converted", LeadStatus.Converted],
    };
}