class User {

}

class Admin extends User {

}

class LostObject {

}

class Report {
  LostObject object;
  String title;
  String description;
  String ubication;
  String category;
  
  Report(this.object, this.title, this.description, this.ubication, this.category);
}