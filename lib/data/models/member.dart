import 'package:cs_onecup/data/models/card.dart';
import 'package:cs_onecup/data/models/deck.dart';
import 'package:cs_onecup/data/models/statistics.dart';

class Member {
  String _id = '';
  String _pw = '';
  String _nickname = '';
  int _level = 1;
  int _expPoint = 0;
  List _cards = <Card>[];
  List _decks = <Deck>[];
  Statistics _statistics = Statistics(0, 0, 0, 0, 0, 0);

  Member(this._id, this._pw, this._nickname, this._level, this._expPoint);
  Member.necessaryArgsConstructor(this._id, this._pw, this._nickname);
  Member.allArgsConstructor(this._id, this._pw, this._nickname, this._level, this._expPoint,
      this._cards, this._decks, this._statistics);

  String get id => _id;
  String get pw => _pw;
  String get nickname => _nickname;
  int get level => _level;
  int get expPoint => _expPoint;
  List get cards => _cards;
  List get decks => _decks;
  Statistics get statistics => _statistics;

  @override
  String toString() {
    return 'Member{_id: $_id, _pw: $_pw, _nickname: $_nickname, _level: $_level, _expPoint: $_expPoint, _cards: $_cards, _decks: $_decks, _statistics: $_statistics}';
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      'id' : member.id,
      'pw' : member.pw,
      'nickname' : member.nickname,
      'level' : member.level,
      'exp_point' : member.expPoint,
      'cards' : member.cards,
      'decks' : member.decks,
      'statistics' : Statistics.toJson(member.statistics)
    };
  }

  static Member fromJson(Map<String, dynamic> memberMap) {
    return Member.allArgsConstructor(
        memberMap['id'], memberMap['pw'], memberMap['nickname'], memberMap['level'], memberMap['exp_point'],
        List<Card>.from(memberMap['cards']), List<Deck>.from(memberMap['decks']), Statistics.fromJson(memberMap['statistics'])
    );
  }
}