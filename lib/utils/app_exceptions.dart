class AppException implements Exception {
  final String message;
  final String prefix;
  final String? url;

  AppException(this.message, this.prefix, this.url);
  
}

class BadRequetException extends AppException{
  BadRequetException([String? message, String? url ]) : super(message!, 'Bad request', url!);
}


class FetchDataException extends AppException{
  FetchDataException([String? message, String? url ]) : super(message!, 'Uncable to prosess', url);
}

class ApiNotRespondingException extends AppException{
  ApiNotRespondingException([String? message, String? url ]) : super(message!, 'Api not response', url);
}


class UnAuthorizedException extends AppException{
  UnAuthorizedException([String? message, String? url ]) : super(message!, 'UnAuthorized request', url!);
}



class NoInternetException {
  String message;
  NoInternetException(this.message);
}
 
class NoServiceFoundException {
  String message;
  NoServiceFoundException(this.message);
}
 
class InvalidFormatException {
  String message;
  InvalidFormatException(this.message);
}
 
class UnknownException {
  String message;
  UnknownException( this.message);
}