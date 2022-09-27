void main() async {
  DateTime dt1 = DateTime.parse("2012-02-27 13:27:00");
  DateTime dt2 = DateTime.parse("2012-02-27 :500");
  DateTime dt3 = DateTime.parse("2012-02-27 13:27:00");

  if(dt1.compareTo(dt2) == 0){
    print("Both date time are at same moment.");
  }

  if(dt3.compareTo(dt1) < 0){
    print("DT3 is before DT1");
  }

  if(dt3.compareTo(dt1) > 0){
    print("DT3 is after DT1");
  }

  if(dt3.compareTo(dt2) < 0){
    print("DT3 is before DT2");
  }

  if(dt3.compareTo(dt2) > 0){
    print("DT3 is after DT2");
  }
}