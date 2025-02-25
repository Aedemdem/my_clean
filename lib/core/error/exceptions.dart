class ServerException implements Exception {
  final int statusCode;
  final String message;
  final String status;

  ServerException({required this.statusCode, required this.message, required this.status});
}