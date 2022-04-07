import 'package:objectbox/objectbox.dart';

@Entity()
class Profile {
  Profile(this.id, this.name,  this.email, this.contactNo);

  Profile.name(this.id, this.name,  this.email, this.contactNo);

  @Id()
  int id;
  String name;
  String email;
  String contactNo;

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, email: $email, contactNo: $contactNo}';
  }
}