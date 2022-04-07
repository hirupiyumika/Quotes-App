import '../db_helper/objectbox_helper.dart';
import '../model/author.dart';
import '../objectbox.g.dart';

class AuthorService {
  AuthorService._internal();

  factory AuthorService.getInstance() {
    return _authorService;
  }

  static final AuthorService _authorService = AuthorService._internal();

  static Store store = ObjectboxHelper.getStore();
  final Box<Author> authorBox = store.box<Author>();

  // Get author by Id. */
  Author? getAuthorById(int authorId) {
    return authorBox.get(authorId);
  }

  /// Get all authors. */
  List<Author> getAll() {
    // List<Author> result = [];
    final List<Author> authorList = authorBox.getAll();
    return authorList;
  }

  /// Create a new author.
  /// author ID should be ZERO. */
  int createAuthor(Author author) {
    /* TODO: check whether this put method is working or not. */
    authorBox.put(author);
    return author.id;
  }

  // Update a existing author. */
  void updateAuthor(Author author) {
    authorBox.put(author);
  }

  // Delete author by Id. */
  void deleteAuthorById(authorId) {
    authorBox.remove(authorId);
  }
}