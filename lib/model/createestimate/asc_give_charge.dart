class ASCGiveCharge {
  final String itemId;
  final double qty;
  final double rate;
  final double amount;
  final double taxPercentage;
  final double taxAmt;
  final String pid;
  final String operator;
  final String condId;
  final String condType;

  ASCGiveCharge(
      this.itemId,
      this.qty,
      this.rate,
      this.amount,
      this.taxPercentage,
      this.taxAmt,
      this.pid,
      this.operator,
      this.condId,
      this.condType);

  ASCGiveCharge.fromJson(Map<String, dynamic> json)
      : itemId = json['ITEMID'],
        qty = json['QTY'],
        rate = json['RATE'],
        amount = json['AMOUNT'],
        taxPercentage = json['TAXPERCENTAGE'],
        taxAmt = json['TXTAMOUNT'],
        pid = json['PID'],
        operator = json['OPERATOR'],
        condId = json['CONDID'],
        condType = json['CONDTYPE'];

  Map<String, dynamic> toJson() => {
    'ITEMID': itemId,
    'QTY': qty,
    'RATE': rate,
    'AMOUNT': amount,
    'TAXPERCENTAGE': taxPercentage,
    'TXTAMOUNT': taxAmt,
    'PID': pid,
    'OPERATOR': operator,
    'CONDID': condId,
    'CONDTYPE': condType
  };
}