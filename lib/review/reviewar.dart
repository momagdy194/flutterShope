class Reviewer {
  String first_name, last_name, email, formatted_Name;

  Reviewer(this.first_name, this.last_name, this.email, this.formatted_Name);

  Reviewer.fromjason(Map<String, dynamic> jasonObject) {
    this.first_name = jasonObject['first_name'];
    this.last_name = jasonObject['last_name'];
    this.email = jasonObject['email'];
    this.formatted_Name = jasonObject['formatted_Name'];
  }
}
