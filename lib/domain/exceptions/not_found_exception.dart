/// Exception is thrown if requested City is not found.
class NotFoundException implements Exception {
  final String? message;

  NotFoundException({this.message});

  @override
  String toString() {
    return message == null
        ? 'NotFoundException'
        : 'NotFoundException: $message';
  }
}
