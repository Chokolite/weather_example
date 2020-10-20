abstract class AbstractCacheManager{
  Future<bool> writeUserData(String key, String item);
  Future<String> getUserData(String key);
  Future<bool> removeUserSingleCache(String key);
  Future<bool> removeUserCache(String key);
}