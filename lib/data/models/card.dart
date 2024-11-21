import 'package:cs_onecup/data/models/quiztype.dart';

class Card {
  int _cardId = 0;
  late QuizType _quizType;
  String _title = '';
  String _category = '';
  String _question = '';
  List _choice = <String>[];
  int _answer = 0;
  String _explanation = '';

  Card.necessaryArgsConstructor(this._cardId, this._quizType, this._category, this._question, this._choice, this._answer, this._explanation);
  Card.allArgsConstructor(this._cardId, this._quizType, this._title, this._category, this._question, this._choice, this._answer, this._explanation);

  String get explanation => _explanation;
  int get answer => _answer;
  List get choice => _choice;
  String get question => _question;
  String get category => _category;
  String get title => _title;
  QuizType get quizType => _quizType;
  int get cardId => _cardId;

  @override
  String toString() {
    return 'Card{_cardId: $_cardId, _quizType: $_quizType, _title: $_title, _category: $_category, _question: $_question, _choice: $_choice, _answer: $_answer, _explanation: $_explanation}';
  }

  static Map<String, dynamic> toJson(Card card) {
    return {
      'card_id' : card.cardId,
      'quiz_type' : card.quizType.toString(),
      'title' : card.title,
      'category' : card.category,
      'question' : card.question,
      'choice' : card.choice,
      'answer' : card.answer,
      'explanation' : card.explanation
    };
  }

  static Card fromJson(Map<String, dynamic> cardMap) {
    return Card.allArgsConstructor(
        cardMap['card_id'], cardMap['quiz_type'], cardMap['title'], cardMap['category'],
        cardMap['question'], List<String>.from(cardMap['choice']), cardMap['answer'], cardMap['explanation']
    );
  }
}