import 'package:quotes_app/model/quote.dart';
import '../db_helper/objectbox_helper.dart';
import '../objectbox.g.dart';

class QuoteService {
  QuoteService._internal();

  factory QuoteService.getInstance() {
    return _quoteService;
  }

  static final QuoteService _quoteService = QuoteService._internal();

  static Store store = ObjectboxHelper.getStore();
  final Box<Quote>quoteBox = store.box<Quote>();

  // Get quote by Id. */
  Quote? getQuoteById(int quoteId) {
    return quoteBox.get(quoteId);
  }

  /// Get all quotes. */
  List<Quote> getAll() {
    // List<Quote> result = [];
    final List<Quote> quoteList = quoteBox.getAll();
    return quoteList;
  }

  /// Create a new quote.
  /// quote ID should be ZERO. */
  int createQuote(Quote quote) {
    quoteBox.put(quote);
    return quote.id;
  }

  // Update a existing quote. */
  void updateQuote(Quote quote) {
    quoteBox.put(quote);
  }

  // Delete quote by Id. */
  void deleteQuoteById(quoteId) {
    quoteBox.remove(quoteId);
  }
}