# Mobex Go flutter application

Functionality
=============
1) Firebase integration:
   That is only for used to image upload

Programming functionality
========================
1) BLoC Event pattern (read https://pub.dev/packages/flutter_bloc)
2) utils package:
   - extensions.dart: validation, toast.
   - vars.dart: const define.
3) service package:
   - network package:
      network_service.dart: Api list, headers define, response from api.
   - viewmodel package:
     mock_service.dart: Offline display data.
4) main.dart: Every time first run screen.
   - Injector.configure(Flavor.Testing); - offline
   - Injector.configure(Flavor.Network); - online

credential
----------
mobextrade.firebase@gmail.com
password: trade@123


Total Screen
============
1) Splash Screen     (splash_screen.dart)
2) Login Screen      (login_page.dart)

3) Tab Screen        (TabCollectMobile.dart)
-------------
1) Pick Up           (tab_pick_up.dart)
2) Dispatch          (tab_dispatch.dart)
3) Postpone          (tab_postpone.dart)

4) ASC / HO Mobile   (mobile_repair_asc_ho.dart)
5) Profile Screen    (profile_page.dart)
6) Dashboard Screen  (profile_page.dart)
7) Contact Us Screen (contact_page.dart)
8) Logout

Meaning
--------
HO: Mobile repair our company
ASC: Mobile repair ASC (Outside)
LONER - Repair mobile then use company mobile to customer.
HO SUBMIT - Mobile submit (dispatch) company.

Screen description
==================
1) Splash Screen, timer is finish open the login screen. This function name is _loginGo()
2) Login Screen, login is successful then after open the screen is Tab Screen. This function name is _loginToApi()

3) Tab Screen, Tab screen contain three tab 1) Pick up, 2) Dispatch and 3) Postpone.
   1) Pick up:
      - Done: Mobile pick up after process this mobile is submit (repair) asc / Ho is decided only for biker boy).
              1) If submit mobile asc, show the data asc/ho mobile list status is ASC SUBMIT.
              2) If submit mobile ho, show the data asc/ho mobile list status is HO SUBMIT.
      - Postpone: Reschedule pick up mobile.
      - Cancel: Mobile not pick up.

   2) Dispatch (dispatch means submit mobile customer)
      - Done: Repair mobile submit to customer.
      - Postpone: Dispatch the mobile customer, some of reason than reschedule.
      - Undelivered: That reason is select only mobile is repair after found mobile issues.

   3) Postpone: Show the data only dispatch data pickup postpone and dispatch postpone.

4) ASC / HO Mobile
   ASC MOBILE SUBMIT
   =================
   STEP: 1
   -------
   - HO SUBMIT: Mobile repair our company after remove the
   - ASC SUBMIT:  Mobile repair ASC.
     1) Select ASC
     2) Enter name and mobile no asc.
     3) Mobile photo max 5.
     4) Submit: ASC SUBMIT CHANGE THE STATUS CREATE ESTIMATE

   STEP: 2
   -------
   - Create estimate part price is decide only asc.
   - SERVICE CHARGES MUST BE ENTER.
   - If PCB and SUB PCB enter the value must be capture photo both PCB and SUB PCB photo.
   - ASC OF ESTIMATE PRESS BUTTON THEN STATUS IS CHANGE waiting for Approval.

   STEP: 3
   -------
   - If estimate approved and estimate rejected both cases collect mobile.
     1) Estimate approved (BUTTON NAME - RECEIVE ASC)
        - Estimate approved then enter name, mobile.
        - GET the invoice copy?
          true: Must be capture photo invoice.
        - Collect of mobile faulty par?
          if mobile repair collect the faulty part.
        - Mobile repair or not?
          1) Yes: Mobile repair
          2) No: If estimate approved but mobile not repair.
        - Last process this case Mobile dispatch customer or Ho. That data is display dispatch tab.

     2) Estimate rejected
        - Enter name and mobile no. asc.
        - max 5 photo capture.
        - Last process this case Mobile dispatch customer or Ho. That data is display dispatch tab.

   HO MOBILE SUBMIT
   ================
   Button name is HO SUBMIT click the submit mobile our company.

