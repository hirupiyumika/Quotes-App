import 'package:objectbox/objectbox.dart';

@Entity()
class Quote {
  Quote();

  // Quote(this.id, this.quote, this.status); // this.author,

  // Named constructor
  Quote.name(
      {this.id = 0,
      this.quote = '',
      this.status = 'active'}); // this.author = '',

  @Id()
  int id = 0;

  // String author;
  String quote = '';
  String status = 'active';

  @override
  String toString() {
    return 'Quote{id: $id, quote: $quote, status: $status}';
  }

// @override
// String toString() {
//   return 'Quotes{id: $id, , quote: $quote, status: $status}'; // author: $author
// }
}
