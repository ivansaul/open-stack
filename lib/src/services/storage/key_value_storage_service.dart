/// A service that provides an interface to store and retrieve key-value pairs
/// in a local storage.
abstract class KeyValueStorageService {
  /// Sets the value associated with the given [key].
  Future<void> setKeyValue<T>(String key, T value);

  /// Gets the value associated with the given [key].
  ///
  /// Returns `null` if there is no such key.
  Future<T?> getValue<T>(String key);

  /// Removes the value associated with the given [key].
  ///
  /// Returns `false` if there is no such key.
  Future<bool> removeKey(String key);
}
