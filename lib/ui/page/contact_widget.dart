import 'package:mobex_go/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/contact/contact_bloc.dart';
import 'package:mobex_go/bloc/contact/contact_state.dart';
import 'package:mobex_go/model/contact/contact_response.dart';
import 'package:mobex_go/ui/widget/flutter_ticket.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatefulWidget {
  ContactWidget({Key key}) : super(key: key);

  @override
  ContactWidgetState createState() => ContactWidgetState();
}

class ContactWidgetState extends State<ContactWidget> {
  ContactBloc contactBloc;

  @override
  void initState() {
    contactBloc = BlocProvider.of<ContactBloc>(context);
    contactBloc.contact();

    super.initState();
  }

  addressCard(ContactResponse contactResponse) => Container(
      padding: const EdgeInsets.all(10.0),
      child: FlutterTicket(
          isCornerRounded: true,
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 5, bottom: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contactResponse.name,
                        style: TextStyle(
                          fontFamily: quickFont,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Address',
                      style: TextStyle(
                          fontFamily: quickFont,
                          fontSize: 15.0,
                          color: Colors.black38),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      contactResponse.address,
                      style: TextStyle(
                          fontFamily: quickFont,
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    contactResponse.mobile.isEmpty
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              launch("tel:" +
                                  contactResponse.mobile.replaceAll(" ", ""));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.call,
                                      size: 20.0, color: Colors.black54),
                                  SizedBox(width: 3),
                                  Text(contactResponse.mobile,
                                      style: TextStyle(
                                          fontFamily: quickFont,
                                          fontSize: 15.0,
                                          color: Colors.black54)),
                                ]))
                  ]))));

  _bodyData() => BlocBuilder(
      bloc: contactBloc,
      builder: (context, ContactState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.contactList));

  _bodyList(List<ContactResponse> listContact) => ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: listContact.length,
      itemBuilder: (context, position) {
        var contactResponse = listContact[position];
        return addressCard(contactResponse);
      });

  @override
  Widget build(BuildContext context) => Container(child: _bodyData());
}
