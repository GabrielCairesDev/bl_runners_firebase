class CustomException extends Error {
  final String message;
  CustomException({required this.message});
  @override
  String toString() {
    return message;
  }
}
