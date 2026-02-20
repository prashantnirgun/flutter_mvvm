class MyException implements Exception {
  String title;
  String message;

  MyException({required this.title, required this.message});

  @override
  String toString() => '$title : $message';
}

class NoInternetException extends MyException {
  NoInternetException({required super.message}) : super(title: "No Internet");
}

///500 and above
class ServerException extends MyException {
  ServerException({required super.message}) : super(title: "Server Error");
}

class BadRequestException extends MyException {
  BadRequestException({required super.message}) : super(title: "Bad Request");
}

class UnauthorizedException extends MyException {
  UnauthorizedException({required super.message})
    : super(title: "Unauthorized");
}

///404
class NotFoundException extends MyException {
  NotFoundException({required super.message}) : super(title: "Not Found");
}

class InvalidInputException extends MyException {
  InvalidInputException({required super.message})
    : super(title: "Invalid Input");
}
