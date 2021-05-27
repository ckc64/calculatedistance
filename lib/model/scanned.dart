class Scanned{
  String id;
  String firstname;
  String lastname;
  String gender;
  String address;
  String estabusername;
  String time;

  Scanned.fromMap(Map<String, dynamic>data){
    id=data['id'];
    firstname=data['firstname'];
    lastname=data['lastname'];
    gender=data['gender'];
    address=data['address'];
    estabusername=data['establishmentusername'];
    time=data['now'];
  }
}