import 'package:objectbox/objectbox.dart';

@Entity()
@Sync()
class Details {
  int id;
  String firstName;
  String lastName;
  String gender;
  int age;

  Details({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.age,
  });
}
