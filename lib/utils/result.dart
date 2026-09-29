/// The outcome of an operation that can fail, returned instead of throwing
/// across layer boundaries.
sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>;
  const factory Result.error(Exception error) = Error<T>;
}

/// A successful [Result].
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

/// A failed [Result].
final class Error<T> extends Result<T> {
  const Error(this.error);

  final Exception error;
}
