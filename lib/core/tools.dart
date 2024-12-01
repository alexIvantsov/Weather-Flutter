import 'package:weather/domain/exceptions/unexpected_exception.dart';

/// Run the given [action] and catch any exception that occurs.
///
/// If an exception occurs,
/// [onException] will be called with the exception and stack trace.
Future<T> runCatching<T>({
  required Future<T> Function() action,
  required T Function(Exception exception, StackTrace stackTrace) onException,
}) async {
  try {
    return await action();
  } on Exception catch (exception, stackTrace) {
    return onException(exception, stackTrace);
  } catch (exception, stackTrace) {
    return onException(UnexpectedException.from(exception), stackTrace);
  }
}
