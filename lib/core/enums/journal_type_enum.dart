enum JournalType {
  text('text'),
  image('image');

  final String type;
  const JournalType(this.type);
}

extension ConvertJournal on String {
  JournalType toJournalTypeEnum() {
    switch (this) {
      case 'text':
        return JournalType.text;
      case 'image':
        return JournalType.image;
      default:
        return JournalType.text;
    }
  }
}