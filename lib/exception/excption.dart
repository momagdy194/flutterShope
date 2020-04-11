class LoginFailed implements Exception {
  @override
  String toString() {
    return 'login failed please login';
  }
}

class RegisterException implements Exception {
  @override
  String toString() {
    return 'eror register';
  }
}

class ResourceNotFound implements Exception {
  String message;


  ResourceNotFound(this.message);


  @override
  String toString() {
    return 'resourse ${ this.message} not foundyy!!!';
  }
}

class RedirectionFound implements Exception {
  @override
  String toString() {
    return 'TOO MANY REDIRCTION!!!';
  }
}

class NoInterNetConnection implements Exception {

  @override
  String toString() {
    return 'NoInterNetConnection{}';
  }
}

class PropertyIsRequired implements Exception {
  String field;

  PropertyIsRequired(this.field);

  @override
  String toString() {
    return 'proberty ${this.field} is Requerd';
  }
}
