import 'package:intl/intl.dart';


class timeStream{

  String? day;
  String? min;
  timeStream({required this.day,required this.min});
  timeStream.FromMap(DateTime date){
    day=date.day.toString();
    min=date.minute.toString();
  }
}