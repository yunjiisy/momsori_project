class Diary {
  int _id;
  int _userID;
  int _emotionalState;
  int _physicalCondition;
  String _text;
  String _diaryDate;

  int get id => _id;

  int get userID => _userID;

  String get diaryDate => _diaryDate;

  String get text => _text;

  int get physicalCondition => _physicalCondition;

  int get emotionalState => _emotionalState;

  Diary(this._id, this._userID, this._emotionalState, this._physicalCondition,
      this._text, this._diaryDate);
}
