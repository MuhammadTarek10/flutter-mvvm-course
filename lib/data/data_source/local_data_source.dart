import 'package:stores/data/network/error_handler.dart';
import 'package:stores/data/response/responses.dart';

const cacheHomeKey = 'CACHE_HOME_KEY';
const cacheStoreDetailsKey = 'CACHE_STORE_DETAILS_KEY';
const cacheHomeInterval = 60 * 1000;
const cacheStoreDetailsInterval = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);

  Future<StoreDetailsDataResponse> getStoreDetails();

  Future<void> saveStoreDetailsToCache(StoreDetailsDataResponse response);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  Future<StoreDetailsDataResponse> getStoreDetails() async {
    CachedItem? cachedItem = cacheMap[cacheStoreDetailsKey];

    if (cachedItem != null && cachedItem.isValid(cacheStoreDetailsInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(
      StoreDetailsDataResponse response) async {
    cacheMap[cacheStoreDetailsKey] = CachedItem(response);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
