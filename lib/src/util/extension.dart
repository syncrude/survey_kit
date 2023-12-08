// Define an extension on the Iterable<T> class to add a new method called `withSeparator`.
extension JoinedIterable<T> on Iterable<T> {
  // The `withSeparator` method takes a `separator` of type `T` as input and returns an Iterable<T>.
  // It allows you to concatenate the elements of the iterable with the specified separator.
  Iterable<T> withSeparator(T separator) {
    // If the iterable is empty, return itself.
    // If the iterable is not empty, use the `expand` method to transform each element
    // into a list containing the element itself and the separator.
    // Then, convert the expanded iterable to a list using `toList
    return isEmpty
        ? this
        : (expand((element) => [element, separator]).toList());
  }
}
