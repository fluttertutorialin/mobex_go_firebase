import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String appName = 'Mobex Go';
const String companyName = 'Mobex Go';
const String companyAddress =
    '4nd Floor, Shashwat Business Park, Opp. Soma Textiles, Rakhial, Ahmedabad- 380023. Gujarat, India.';
const String companyWebsiteUrl = 'http://mobex.in';
const String appUpDateDate = 'Release: 21-11-2019';

const String symbolRs = '\u20B9 ';

const String drawerHome = 'Home';
const String drawerProfile = 'Profile';
const String drawerDashboard = 'Dashboard';
const String drawerContactUs = 'Contact Us';
const String drawerLogout = 'Logout';

const String titleWelcome = 'Welcome to';
const String titleSignInContinue = 'Sign in to continue';
const String titleProfile = 'Profile';
const String titleContactUs = 'Contact Us';
const String titleAscHoMobileList = 'ASC / HO  Mobile List';
const String titleRepairMobileOrNot = 'Repair Mobile or Not';
const String titleEstimateReject = 'Estimate Reject';
const String titleReturnMobile = 'RETURN MOBILE';
const String titleCreateEstimate = 'Create Estimate';
const String titleLogout = 'Logout';

const String inputHintMobile = 'Mobile';
const String inputHintPassword = 'Password';
const String inputHintName = 'Name';
const String inputHintMobileNotRepair = 'Mobile not repair description';

const String msgNoData = 'No Data';
const String msgDonePickUp = 'Are you sure pickup is done?';
const String msgReturnMobileNotSuccessful = 'Return mobile not successful';
const String msgDoneDispatch = 'Are you sure dispatch is done?';
const String msgEstimateAmountValueEmpty = 'Estimate amount value empty';
const String msgNotCreateEstimate = 'Not create estimate';
const String msgRejectNotSuccessful = 'Reject not successful';
const String msgPickUpNotSuccessful = 'Pick up not successful';
const String msgHoMobileNotSubmitted = 'Ho mobile not submitted';
const String msgAscMobileNotSubmitted = 'ASC mobile not submitted';
const String msgNotSelectPickUpMobileBoxPhoto = 'Pick up mobile box photo';
const String msgRepairMobileAscHo = 'Repair mobile ASC or HO';
const String msgReceiveMobileBoxHo = 'Receive mobile box photo';
const String msgRejectMobileBoxPhoto = 'Reject mobile box photo';
const String msgAscNotSubmit = 'ASC not submit successful';
const String msgSelectMobileRepairOrNot = 'Select mobile repair or not';
const String msgPcBSubPcbPhoto = 'Pcb or sub pcb photo';
const String msgServiceCharge = 'Service charges is empty';
const String msgPcBSubPcb2Photo = 'Pcb and sub pcb photo must';

const String optionHo = 'HO';
const String optionAsc = 'ASC';

//TODO LABEL
const String labelHO = 'HO';
const String labelASC = 'ASC';
const String labelNoLoaner = 'NO LOANER';
const String labelLoaner = 'LOANER';
const String labelHo = 'HO';
const String labelRepairMobile = 'Repair mobile';
const String labelPickUpBoxPhoto = 'Pick up mobile box photo';
const String labelRejectBoxPhoto = 'Reject mobile box photo';
const String labelReceiveBoxPhoto = 'Receive mobile box photo';
const String labelMobileBoxPhoto = 'Mobile box photo';
const String labelPcBSubPcbPhoto = 'PCB or SUB PCB photo';
const String labelInvoicePhoto = 'Invoice photo';
const String labelSelectDate = 'Select date';
const String labelSelectTime = 'Select time';
const String labelSelectReason = 'Select reason for ';
const String labelName = 'Name';
const String labelSureLogout = 'Are you sure want to logout?';
const String labelUserName = 'Username';
const String labelLoginDateTime = 'Login date time :';
const String labelMobile = 'Mobile: ';
const String labelAddress = 'Address: ';
const String labelMobileRepairOrNot = 'Mobile repair or not?';
const String labelEstimate = 'Estimate ';
const String labelDispatchMobile = 'Dispatch mobile';
const String labelTotalAmountIncludeGst = 'TOTAL AMOUNT INCLUDE GST';

//TODO ASSETS
const String imageProfile = 'assets/images/user_profile.png';

//TAB
const String tabPickUp = 'Pick up';
const String tabDispatch = 'Dispatch';
const String tabPostpone = 'Postpone';
const String tabASC = 'ASC';
const String tabHO = 'HO';

//TODO FONT NAME
const String quickFont = 'Quicksand';
const String ralewayFont = 'Raleway';

const String quickBoldFont = 'quicksand_book.otf';
const String quickNormalFont = 'quicksand_book.otf';
const String quickLightFont = 'quicksand_light.otf';

const String ralewayRegularFont = 'raleway_medium.ttf';

//TODO ROUTE
const String homeRoute = '/homepage';
const String SplashScreenRoute = '/splash_screen';
const String loginRoute = '/login';
const String signUpRoute = '/signup';
const String forgotPasswordRoute = '/forgot_password';
const String tabRoute = '/tab_route';
const String postPonReasonRoute = '/postpon_reason';
const String dashBoardRoute = '/dashboard';
const String profileRoute = '/profile';
const String contactRoute = '/contact';
const String webSiteRoute = '/website';
const String searchRoute = '/search';

const String mobileRepairAscHoRoute = '/MobileRepairAscHoPage';

const String btnDone = 'DONE';
const String btnPostpone = 'POSTPONE';
const String btnCancel = 'CANCEL';
const String btnLogout = 'Logout';
const String btnUndelivered = 'UNDELIVERED';
const String btnSubmit = 'SUBMIT';
const String btnAscSubmit = 'ASC SUBMIT';
const String btnHoSubmit = 'HO SUBMIT';
const String btnAscOfEstimate = 'ASC OF ESTIMATE';
const String btnAscHoMobileList = 'ASC / HO MOBILE LIST';
const String btnDispatchMobileCustomer = 'CUSTOMER';
const String btnDispatchMobileHo = 'HO';

const String statusHo = "HO";
const String statusProductPickedUp = "Product Picked Up";
const String statusAtASC = "At ASC";
const String statusWaitingForApproval = "Estimated";
const String statusWaitingForApprovalBothSame = "Waiting for Approval";
const String statusApproved = "APPROVED";
const String statusRejected = "REJECTED";

const String statusProductPickedUpFor = 'ASC SUBMIT';
const String statusAtASCFor = 'CREATE ESTIMATE';
const String statusWaitingForApprovalFor = 'Waiting for Approval';
const String statusApprovedFor = 'ESTIMATE APPROVED';
const String statusRejectedFor = 'ESTIMATE REJECTE';
const String statusApproveOrRejectFor = 'RECEIVE ASC';

const String empIdParam = 'EMPID';
const String empMobileParam = 'MOBILENO';
const String jobIdParam = 'JOBID';
const String jobNoParam = 'JOBNO';
const String mobileNoParam = 'MobileNo';
const String passwordParam = 'Password';
const String deviceIdParam = 'DeviceId';
const String assignToPlaceParam = 'ASSIGNTOPLACE';
const String inquiryNoParam = 'INQUIRYNO';
const String isLoanerPhoneParam = 'LNRPHONE';
const String imageTypeParam = 'IMAGETYPE';
const String bikerIdParam = 'BIKERID';
const String bikerNameParam = 'BIKERNAME';
const String imageParam = 'IMAGE';
const String pickedUpdateParam = 'PICKEDUPDATE';
const String pickedTimeParam = 'PICKEDUPTIME';
const String ascNameParam = 'ASCNAME';
const String ascCodeParam = 'ASCCODE';
const String problemMobileParam = 'PROBLEM_TECH';
const String ascPersonNameParam = 'CONTACTPERSON';
const String ascPersonMobileParam = 'CONTACTPERSONNO';
const String repairMobileParam = 'REPAIRSTATUS';
const String invoiceGetParam = 'REPAIRINVOCE';
const String faultyPartParam = 'FAULTYPART';
const String dispatchMobileParam = 'DISPATCHTO';
const String returnReasonNameParam = 'RETURNREASON';
const String collectLoanerPhoneParam = 'COLLECTLNRPH';
const String dispatchDoneDateParam = 'DELIDATE';
const String dispatchDoneTimeParam = 'DELITIME';
const String postponeReasonParam = 'POSTPONDRSN';
const String postponeDateParam = 'POSTPONDATE';
const String postponeTimeParam = 'POSTPONTIME';
const String mobileNotRepairDescriptionParam = 'REMARK';

const String notRepairedApiStatus = 'NOT REPAIRED';
const String receiveImageType = 'R';
const String customerReceiveImageType = 'C';
const String ascSubmitImageType = 'A';
const String createEstimateImageType = 'E';
const String invoiceImageType = 'I';
const String loanerGiveCustomerType = '1';
const String loanerNotGiveCustomerType = '0';
const bool dispatchMobileCustomer = true;
const bool dispatchMobileHo = false;

const String invoiceCopyApiValue = 'Get the invoice copy?';
const String collectFaultyPartApiValue = 'Collect of mobile faulty part?';

const String rejectNotSuccessfulMessage = 'Reject not successful';

//TODO COLOR
const Color colorRoundText = Colors.grey;
Color colorRoundTextBg = Colors.grey.withOpacity(0.1);
Color colorIconCall = Colors.orange.shade200;
Color colorIconMap = Colors.blue.shade200;
const Color colorInquiryNo = Colors.lightBlue;
const Color colorDate = Colors.black26;
const Color colorRs = Colors.lightBlue;
const Color colorName = Colors.black;
const Color colorModel = Colors.black45;
const Color colorMobile = Colors.grey;
const Color colorAddress = Colors.black87;
const Color colorReason = Colors.deepOrangeAccent;
const Color colorNoData = Colors.grey;

const Color colorProgressBar = Colors.black54;
const Color colorTitle = Color.fromRGBO(241, 81, 41, 1);

List<Color> gradientsClipper = [
  Colors.grey.shade200,
  Colors.white
];

List<Color> gradientsButton = [Colors.grey.shade200, Colors.white];

List<Color> kitGradients = [
  Colors.white,
  Colors.white,
];

//TODO WIDGET
expandStyle(int flex, Widget child) => Expanded(flex: flex, child: child);

showProgress(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
          ));
}

hideProgress(BuildContext context) {
  Navigator.pop(context);
}

toast(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black);
}

//VALIDATION
String validateMobile(String value) {
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value.replaceAll(" ", "").isEmpty) {
    return 'Mobile is required';
  } else if (value.replaceAll(" ", "").length != 10) {
    return 'Mobile number must 10 digits';
  } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
    return 'Mobile number must be digits';
  }
  return null;
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 4) {
    return 'Password must be at least 4 characters';
  }
  return null;
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return 'Name is required';
  } else if (!regExp.hasMatch(value)) {
    return 'Name must be a-z and A-Z';
  }
  return null;
}

String validateEmpty(String value) {
  if (value.isEmpty) {
    return 'Why mobile not repair?';
  }
  return null;
}



int ok200 = 200;
String apiCode1 = '1';
