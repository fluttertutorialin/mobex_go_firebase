import 'package:mobex_go/model/contact/contact_response.dart';

class ContactViewModel {
  getContacts() => <ContactResponse>[
        /*ContactResponse(
          name: 'JDK GROUP',
          address: 'To.Ravani (Kuba) Ta.Visavadar Dis.Junagadh \n Ravani (Kuba) - 362130. \nGujarat, India.',
          mobile: '9586331823',
          websiteName: '',
        ),*/

        ContactResponse(
          name: 'Qarmatek Services Pvt Ltd',
          address:
              '2nd Floor, Shashwat Business Park, \nOpp. Soma Textiles, Rakhial, \nAhmedabad- 380023. \nGujarat, India.',
          mobile: '079 2970 0134',
          websiteName: '',
        )
      ];
}
