class LiveStationResponse {

  int duration;
  int total;
  List<LiveStation> stations;

  LiveStationResponse.fromMap(Map<String, dynamic> data) {

    stations = new List();
    duration = data["duration"];
    total = data["total"];
    List stationMap = data["hits"];


    for(Map item in stationMap) {
      try {
        LiveStation liveStation = new LiveStation.fromMap(item);
        stations.add(liveStation);
      } catch (e) {
        print(e);
      }
    }

  }

}


class LiveStation {

  int id;
  int score;
  String name;
  String responseType;
  String description;
  String band;
  String callLetters;
  String logo;
  String freq;
  int cume;
  String countries;
  Streams streams;
  bool isActive;
  String modified;
  List<Market> markets;
  List<Genre> genres;
  String esid;
  Feeds feeds;
  String format;
  String provider;
  String rds;
  String website;
  Social social;
  String email;
  Adswizz adswizz;
  AdswizzZones adswizzZones;
  String callLetterAlias;
  String callLetterRoyalty;
  String fccFacilityId;
  String rdsPiCode;

  LiveStation.fromMap(Map<String, dynamic> data) {
    id =  data["id"];
    name = data["name"];
    description =  data["description"];
    band = data["band"];
    callLetters = data["callLetters"];
    logo = data["logo"];
    streams = new Streams.fromMap(data["streams"]);

    List genreList = data["genres"];

    genres = new List();

    for(Map genre in genreList) {
      Genre item = new Genre.fromMap(genre);
      genres.add(item);
    }

  }

}

class Market {

  String name;
  String marketId;
  int sortIndex;
  String city;
  int stateId;
  String stateAbbreviation;
  int cityId;
  String country;
  int countryId;
  bool primary;
  bool origin;

}

class Social {

  String twitter;
  String facebook;

}

class Streams {

  String hlsStream;
  String shoutcastStream;
  Object pivotHlsStream;
  String secureHlsStream;
  String secureShoutcastStream;
  String plsStream;
  Object secureRtmpStream;
  String stwStream;
  String securePlsStream;
  String flvStream;

  Streams.fromMap(Map<String, dynamic> data) {
    hlsStream = data["hls_stream"];
    shoutcastStream = data["shoutcast_stream"];

    secureHlsStream = data["secure_hls_stream"];
    secureShoutcastStream = data["secure_shoutcast_stream"];

  }

}

class Adswizz {

  String publisherId;
  String adswizzHost;
  String enableAdswizzTargeting;

}

class AdswizzZones {

  String audioFillZone;
  String audioZone;
  String optimizedAudioFillZone;
  String audioExchangeZone;
  String displayZone;

}

class Genre {

  int id;
  String name;
  int sortIndex;
  bool primary;

  Genre.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    sortIndex = data["sortIndex"];
    primary = data["primary"];
  }

}

class Feeds {
  String feed;

}