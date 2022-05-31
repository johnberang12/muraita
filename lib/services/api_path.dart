
class APIPath {
  static String listing(String uid, String listingId) => '/users/$uid/listings/$listingId';
  static String listings(String uid) => 'users/$uid/listings';
}