class BillDetails {
  String cargoType;
  String packaging;
  String weight;
  double price;
  String paymentDueDate;
  String paidDate;
  String billStatus;
  BillDetails(
      {this.cargoType = '',
      this.packaging = '',
      this.weight = '',
      this.price = 0,
      this.paymentDueDate = '',
      this.paidDate = '',
      required this.billStatus,
      });
}
