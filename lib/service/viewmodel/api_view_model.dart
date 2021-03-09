import 'package:mobex_go/model/asc/asc_list.dart';
import 'package:mobex_go/model/asc/problem_list.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import 'package:mobex_go/utils/vars.dart';

getAscHo() => <AssignAscHoResponse>[
  AssignAscHoResponse(
      inquiryNo: 00001,
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '25-02-2019 10:51PM',
      status: statusWaitingForApproval,
      jobId: '00001',
      assign: 'ASC',
      estimate: '0000'),
  AssignAscHoResponse(
      inquiryNo: 00002,
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '25-02-2019 10:51PM',
      status: statusApproved,
      jobId: '00002',
      assign: 'ASC',
      estimate: '0000'),
  AssignAscHoResponse(
      inquiryNo: 00003,
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '25-02-2019 10:51PM',
      status: statusRejected,
      jobId: '00003',
      assign: 'ASC',
      estimate: '0000'),
  AssignAscHoResponse(
      inquiryNo: 00004,
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '25-02-2019 10:51PM',
      status: statusProductPickedUp,
      jobId: '00004',
      assign: 'ASC',
      estimate: '0000'),
  AssignAscHoResponse(
      inquiryNo: 00005,
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '25-02-2019 10:51PM',
      status: statusProductPickedUp,
      jobId: '00005',
      assign: 'HO',
      estimate: '0000'),
  AssignAscHoResponse(
      inquiryNo: 00006,
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '25-02-2019 10:51PM',
      status: statusAtASC,
      jobId: '00006',
      assign: 'ASC',
      estimate: '0000'),
];

getPickUp() => <PickUpResponse>[
  PickUpResponse(
      inquiryNo: 00001,
      jobId: '00001',
      name: 'Testing',
      brand: 'MI',
      mobile: '0000000000',
      address: 'Address',
      model: 'A2',
      pickUpDateTime: '20-02-2019 10:51PM'),
];

getDispatch() => <DispatchResponse>[
  DispatchResponse(
      jobId: '1',
      lonerPhone: 1,
      name: 'Testing',
      mobile: '0000000000',
      address: 'Address',
      brand: 'MI',
      model: 'A2',
      codAmount: 1200.00,
      dispatchDateTime: '25-02-2019 10:51PM',
      dispatchMobile: true),
  DispatchResponse(
      jobId: '2',
      lonerPhone: 0,
      name: 'Testing',
      mobile: '0000000000',
      address: 'Address',
      brand: 'MI',
      model: 'A2',
      codAmount: 1300.00,
      dispatchDateTime: '25-02-2019 10:51PM',
      dispatchMobile: false),
  DispatchResponse(
      jobId: '3',
      lonerPhone: 0,
      name: 'Testing',
      mobile: '0000000000',
      address: 'Address',
      brand: 'MI',
      model: 'A2',
      codAmount: 1200.00,
      dispatchDateTime: '25-02-2019 10:51PM',
      dispatchMobile: true),
  DispatchResponse(
      jobId: '4',
      lonerPhone: 0,
      name: 'Testing',
      mobile: '0000000000',
      address: 'Address',
      brand: 'MI',
      model: 'A2',
      codAmount: 1200.00,
      dispatchDateTime: '25-02-2019 10:51PM',
      dispatchMobile: true),
];

getPostPone() => <PostPoneResponse>[
  PostPoneResponse(
      description: 'Pickup',
      refNo: 0001,
      id: 1.00,
      lonerPhone: '1',
      assignTime: '20-02-2019 10:51PM',
      postponeTime: '24-02-2019 10:51PM',
      postponedReason: 'Outside',
      contactNo: '0000000000',
      endCustomer: 'Testing',
      fullAddress: 'Address',
      brand: 'MI',
      model: 'A2',
      codAmount: 1200.00),
  PostPoneResponse(
      description: 'Dispatch',
      refNo: 0001,
      id: 1.00,
      lonerPhone: '1',
      assignTime: '20-02-2019 10:51PM',
      postponeTime: '24-02-2019 10:51PM',
      postponedReason: 'Outside',
      contactNo: '0000000000',
      endCustomer: 'Testing',
      fullAddress: 'Address',
      brand: 'MI',
      model: 'A2',
      codAmount: 1200.00)
];

getReasonPostPoneCancel() => <ReasonResponse>[
  ReasonResponse(
    isSelected: false,
    id: 1,
    reasonName: 'ADDRESS CHANGED',
  ),
  ReasonResponse(
    isSelected: false,
    id: 2,
    reasonName: 'BACKUP PENDING',
  ),
  ReasonResponse(
    isSelected: false,
    id: 3,
    reasonName: 'CALL LETTER',
  ),
  ReasonResponse(
    isSelected: false,
    id: 4,
    reasonName: 'DOOR LOCKED',
  ),
  ReasonResponse(
    isSelected: false,
    id: 5,
    reasonName: 'DUPLICATE INQUIRY',
  ),
  ReasonResponse(
    isSelected: false,
    id: 6,
    reasonName: 'HIGH ESTIMATE',
  ),
  ReasonResponse(
    isSelected: false,
    id: 7,
    reasonName: 'INCOMPLETE/INACCURATE INFORMATION',
  ),
  ReasonResponse(
    isSelected: false,
    id: 8,
    reasonName: 'NOT AGREE',
  ),
  ReasonResponse(
    isSelected: false,
    id: 9,
    reasonName: 'NOT AVIALABLE',
  ),
  ReasonResponse(
    isSelected: false,
    id: 10,
    reasonName: 'NOT RESPONDING',
  ),
  ReasonResponse(
    isSelected: false,
    id: 11,
    reasonName: 'OUT OF STATION',
  ),
  ReasonResponse(
    isSelected: false,
    id: 12,
    reasonName: 'PHONE MISPLACED',
  ),
  ReasonResponse(
    isSelected: false,
    id: 13,
    reasonName: 'PHONE NOT IN REPAIRABLE CONDITION',
  ),
  ReasonResponse(
    isSelected: false,
    id: 14,
    reasonName: 'WRONG NUMBER',
  )
];

getReasonUndelivered() => <ReasonResponse>[
  ReasonResponse(
    isSelected: false,
    id: 1,
    reasonName: 'DATA MISSING',
  ),
  ReasonResponse(
    isSelected: false,
    id: 2,
    reasonName: 'DON NOT HAVE JOBSHEET',
  ),
  ReasonResponse(
    isSelected: false,
    id: 3,
    reasonName: 'DUPLICATE PARTS',
  ),
  ReasonResponse(
    isSelected: false,
    id: 4,
    reasonName: 'FITTING ISSUE',
  ),
  ReasonResponse(
    isSelected: false,
    id: 5,
    reasonName: 'OTHER PROBLEM FOUND',
  ),
  ReasonResponse(
    isSelected: false,
    id: 6,
    reasonName: 'PAYMENT ISSUE',
  ),
  ReasonResponse(
    isSelected: false,
    id: 7,
    reasonName: 'PROBLEM NOT SOLVED',
  ),
];

getAscList() => <AscListResponse>[
  AscListResponse(
      isSelected: false,
      vendCode: "0000010009",
      name: "Title 1",
      address1: "Address",
      city: "AHMEDABAD",
      postalCode: "380 024"),

  AscListResponse(
      isSelected: false,
      vendCode: "0000010121",
      name: "Title 2",
      address1: "Address",
      city: "AHMEDABAD",
      postalCode: "380023"),
];

getAscProblem() => <ProblemListResponse>[
  ProblemListResponse(
      id: 4190.0,
      problemName: "LCD",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 8507.0,
      problemName: "TOUCH LCD",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 41984.0,
      problemName: "GLASS",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 66172.0,
      problemName: "BACK CAMERA",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 31081.0,
      problemName: "FRONT CAMERA",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 41917.0,
      problemName: "BATTERY",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 42026.0,
      problemName: "BACK COVER",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 6404.0,
      problemName: "PCB",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 7762.0,
      problemName: "CHARGING BELT",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 31080.0,
      problemName: "FPC BELT",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
  ProblemListResponse(
      id: 42027.0,
      problemName: "SERVICE CHARGES",
      condType: "GST",
      netRate: 18.00,
      condId: 12.0,
      pId: 0.0,
      operator: "+",
      enterValue: ''),
];
