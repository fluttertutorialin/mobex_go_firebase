import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SelectAscState {
  final int inquiryNo;
  final String jobId, name, brand, mobile, address, model;

  SelectAscState(
      {@required this.inquiryNo,
      @required this.jobId,
      @required this.name,
      @required this.brand,
      @required this.mobile,
      @required this.address,
      @required this.model});

  factory SelectAscState.initial() {
    return SelectAscState(
        inquiryNo: null,
        jobId: null,
        name: null,
        brand: null,
        mobile: null,
        address: null,
        model: null);
  }

  SelectAscState copyWith(
      {int inquiryNo,
      String jobId,
      String name,
      String brand,
      String mobile,
      String address,
      String model}) {
    return SelectAscState(
        inquiryNo: inquiryNo ?? this.inquiryNo,
        jobId: jobId ?? this.jobId,
        name: name ?? this.name,
        brand: brand ?? this.brand,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        model: model ?? this.model);
  }
}
