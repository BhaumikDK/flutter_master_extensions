/// Represents a range exception.
class ExtenedException {
  ExtenedException(this.message);

  ExtenedException.steps() : message = 'The range must be more then 0';

  final String? message;

  @override
  String toString() => 'RException: ${message ?? ''}';
}
