import 'package:cs_onecup/data/models/card.dart';

class Deck {
  int _deckId = 0;
  String _ownerId = '';
  String _name = '';
  int _numberOfCards = 0;
  List _cards = <Card>[];
  List _tags = <String>[];

  Deck(this._deckId, this._ownerId, this._name, this._numberOfCards);
  Deck.necessaryArgsConstructor(this._deckId, this._ownerId, this._name);
  Deck.allArgsConstructor(this._deckId, this._ownerId, this._name, this._numberOfCards, this._cards, this._tags);

  List get tags => _tags;
  List get cards => _cards;
  int get numberOfCards => _numberOfCards;
  String get name => _name;
  String get ownerId => _ownerId;
  int get deckId => _deckId;

  @override
  String toString() {
    return 'Deck{_deckId: $_deckId, _ownerId: $_ownerId, _name: $_name, _numberOfCards: $_numberOfCards, _cards: $_cards, _tags: $_tags}';
  }

  static Map<String, dynamic> toJson(Deck deck) {
    return {
      'deck_id' : deck.deckId,
      'owner_id' : deck.ownerId,
      'name' : deck.name,
      'number_of_cards' : deck.numberOfCards,
      'cards' : deck.cards.map((card) => Card.toJson(card)).toList(),
      'tags' : deck.tags
    };
  }

  static Deck fromJson(Map<String, dynamic> deckMap) {
    return Deck.allArgsConstructor(
        deckMap['deck_id'], deckMap['owner_id'], deckMap['name'], deckMap['number_of_cards'],
        List<Card>.from(deckMap['cards']), List<String>.from(deckMap['tags'])
    );
  }
}