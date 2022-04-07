import 'package:quotes_app/model/quote.dart';

import 'package:objectbox/objectbox.dart';

@Entity()
class Author {
  Author();

  //
  // Author(
  //   this.id,
  //   this.name
  // );

  Author.name(this.quotes, {this.id = 0, this.name = ''});

  @Id()
  int id = 0;
  String name = '';

  ToMany<Quote> quotes = ToMany<Quote>();

  @override
  String toString() {
    return 'Author{id: $id, name: $name, quotes: $quotes}';
  }
}
