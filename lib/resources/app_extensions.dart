/// An extension on the `Object` type to provide a `let` function.
///
/// This extension allows for a safe and concise way to operate on nullable
/// objects. The `let` function takes a function as a parameter, and if the
/// object is not null, it passes the non-null object to that function.
extension ObjectExt<T> on T {
  R let<R>(final R Function(T that) op) => op(this);
}