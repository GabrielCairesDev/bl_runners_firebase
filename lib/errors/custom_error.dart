class CustomError extends Error {
  final String message;
  CustomError({required this.message});
  @override
  String toString() {
    return message;
  }
}
