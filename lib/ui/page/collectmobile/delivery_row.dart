import 'package:flutter/material.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:strings/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryRow extends StatelessWidget {
  final String inquiryNo;
  final String amount;
  final String name;
  final String brand;
  final String mobile;
  final String address;
  final String model;
  final String dateTime;
  final String reason;
  final String deliveryType;
  final String assign;
  final bool submitStatus;

  DeliveryRow(this.inquiryNo, this.name, this.brand, this.mobile, this.address,
      this.model, this.dateTime,
      {this.amount = "",
      this.reason = "",
      this.deliveryType = "",
      this.assign = "",
      this.submitStatus = true});

  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: nameCallMap(assign, name, mobile, address),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            expandStyle(3, widgetInquiryNo(inquiryNo)),
                            expandStyle(2, widgetRs(amount)),
                            expandStyle(2, widgetDateTime(dateTime)),
                          ]),
                      widgetName(name),
                      widgetModel(brand, model),
                      SizedBox(height: 1),
                      widgetMobile(mobile),
                      widgetAddress(submitStatus ? address : companyAddress),
                      widgetReason(reason),
                      widgetDeliveryType(deliveryType)
                    ])))
      ]);
}

_openMap(String pinCode) async {
  String url = 'https://www.google.com/maps/search/?api=1&query=$pinCode';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//TODO PICK UP DETAIL WIDGETS
nameCallMap(String assign, String name, String mobile, String address) =>
    Column(children: [
      GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 18.0,
            child: Text(
              assign.isEmpty ? name.substring(0, 1) : assign,
              style: TextStyle(
                  fontFamily: quickFont,
                  fontWeight: FontWeight.bold,
                  fontSize: assign == null ? 16.0 : 13.0,
                  color: colorRoundText),
            ),
            backgroundColor: colorRoundTextBg,
          )),
      GestureDetector(
          onTap: () {
            launch("tel:" + mobile.replaceAll(" ", ""));
          },
          child: CircleAvatar(
            radius: 19.0,
            child: Icon(Icons.phone, color: colorIconCall),
            backgroundColor: Colors.transparent,
          )),
      GestureDetector(
          onTap: () {
            String pinCode = reverse(address).split(" ")[0];
            _openMap(reverse(pinCode));
          },
          child: CircleAvatar(
            radius: 19.0,
            child: Icon(Icons.map, color: colorIconMap),
            backgroundColor: Colors.transparent,
          ))
    ]);

widgetInquiryNo(String inquiryNo) => Column(children: [
      Text(
        inquiryNo.contains(".") ? inquiryNo.split(".")[0] : inquiryNo,
        style: TextStyle(
            fontFamily: ralewayFont, fontWeight: FontWeight.w300, fontSize: 15.0, color: colorInquiryNo),
      ),
      Container(
        color: colorInquiryNo,
        width: inquiryNo.length <= 3 ? 7.0 * inquiryNo.length : 21.0,
        height: 1.5,
      )
    ], crossAxisAlignment: CrossAxisAlignment.start);

widgetDateTime(String dateTime) => Text(
      dateTime.split(" ")[0] + "\n" + dateTime.split(" ")[1],
      textAlign: TextAlign.right,
      style: TextStyle(fontFamily: ralewayFont, fontWeight: FontWeight.w400, fontSize: 10.0, color: colorDate),
    );

widgetRs(String amount) => Text(
      amount.toString().isEmpty
          ? ''
          : symbolRs + double.parse(amount).toStringAsFixed(2),
      textAlign: TextAlign.right,
      style: TextStyle(fontFamily: ralewayFont, fontWeight: FontWeight.w400, fontSize: 13.0, color: colorDate),
    );

widgetName(String name) => Container(
    margin: EdgeInsetsDirectional.only(top: 4.0),
    child: Text(
      name,
      style: TextStyle(
          fontFamily: quickFont,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: colorName),
    ));

widgetModel(String brand, String model) => Text(
      brand + " - " + model,
      style:
          TextStyle(fontFamily: quickFont, fontSize: 13.0, color: colorModel),
    );

widgetMobile(String mobile) => Text(
      labelMobile + mobile,
      style:
          TextStyle(fontFamily: quickFont, fontSize: 14.0, color: colorMobile),
    );

widgetAddress(String address) => Padding(
    padding: const EdgeInsets.only(top: 3.0),
    child: Text(
      address,
      style: TextStyle(
          fontFamily: quickFont,
          letterSpacing: 0.5,
          fontSize: 14.0,
          color: colorAddress),
    ));

widgetReason(String reason) => reason.isEmpty
    ? Container()
    : Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: Text(
          reason,
          style: TextStyle(
              fontFamily: quickFont, fontSize: 13, color: colorReason),
        ));

widgetDeliveryType(String deliveryType) => deliveryType.isEmpty
    ? Container()
    : Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Text(deliveryType,
              style: TextStyle(fontFamily: quickFont, fontSize: 12.0, color: Colors.black54))
      ]);

//TODO PICKUP BUTTON WIDGETS
buttonTextStyle(String btnName) =>
    Text(btnName, style: TextStyle(fontFamily: quickFont, fontSize: 12.0));
