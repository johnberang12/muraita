
class APIPath {
  static String listing(String uid, String listingId) => '/users/$uid/listings/$listingId';
  static String listings(String uid) => 'users/$uid/listings';
  static String comment(String uid, String commentId) => 'users/$uid/comments/commentId';
  static String comments(String uid) => 'users/$uid/comments';
}