class RecordData {
  int _id;
  int _userID;
  String _filename;
  String _recordDate;

  int get id => _id;

  int get userID => _userID;

  String get recordDate => _recordDate;

  String get filename => _filename;

  RecordData(this._id, this._userID, this._filename, this._recordDate);
}
