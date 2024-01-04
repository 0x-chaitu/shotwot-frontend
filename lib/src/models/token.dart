import 'package:objectbox/objectbox.dart';

@Entity()
class Token {
  @Id(assignable:true)
  late int id;
  
  String? name;
}