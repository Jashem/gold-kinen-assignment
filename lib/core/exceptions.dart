class AppException implements Exception {
  final int? errorCode;
  final String message;

  AppException({
    this.errorCode,
    required this.message,
  });

  String get errorMessage => "${errorCode ?? ""} $message";
}
