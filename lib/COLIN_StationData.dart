class StationData {


  StationData( this._id, this._displayName, this._shortDesc, this._longDesc, this._imageUrl, this._genre, this._displayLocation);

  StationData.empty() {
    _id = "DEFAULT_ID";
    _displayName ="Default Title";
    _shortDesc="Default Short Description";
    _longDesc="Default LLLLOOOOONNNNGGGGG Description";
    _genre="Default Genre";
    _displayLocation="Default display location";
    _imageUrl = 'assets/images/defaultStation.jpg';
  }

  String _id;
  String _displayName;
  String _shortDesc;
  String _longDesc;
  String _imageUrl;
  String _genre;
  String _displayLocation;

  String get id => _id;

  String get displayName => _displayName;

  String get shortDesc => _shortDesc;

  String get longDesc => _longDesc;

  String get imageUrl => _imageUrl;

  String get genre => _genre;

  String get displayLocation => _displayLocation;

}