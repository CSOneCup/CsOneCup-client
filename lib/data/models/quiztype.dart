enum QuizType {
  ox, choice;

  static QuizType fromString(String string) {
    switch(string.toLowerCase()) {
      case 'ox':
        return ox;
      case '4지선다':
        return choice;
      default:
        throw new Exception("QuizType mapping exception : couldn't parse $string");
    }
  }
}