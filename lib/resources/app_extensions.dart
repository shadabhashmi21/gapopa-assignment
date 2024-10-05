extension ObjectExt<T> on T {
  R let<R>(final R Function(T that) op) => op(this);
}