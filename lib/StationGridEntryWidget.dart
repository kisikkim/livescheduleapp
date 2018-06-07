import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/animations/Animations.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';

typedef void ToggledStationButtonCallback(
    StationData stationData, bool newState);

class StationGridEntryWidget extends StatefulWidget {
  final ToggledStationButtonCallback toggledStationButtonCallback;
  final StationData _stationData;

  StationGridEntryWidget(this._stationData, this.toggledStationButtonCallback);

  @override
  StationGridEntryWidgetState createState() =>
      new StationGridEntryWidgetState.fromStationData(
          _stationData, this.toggledStationButtonCallback);
}

class StationGridEntryWidgetState extends State<StationGridEntryWidget>
    with TickerProviderStateMixin {
  ToggledStationButtonCallback _toggledStationButtonCallback;

  bool _selected = false;

  StationGridEntryWidgetAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new StationGridEntryWidgetAnimationController();
    _animationController.init(this, this);
  }

  void _handleTap() {
    setState(() {
      _selected = !_selected;
    });
    if (this._toggledStationButtonCallback != null) {
      this._toggledStationButtonCallback(_stationData, _selected);
    } else {
      print("NULL CALLBACK HANDLER FOR " + _stationData.id);
    }

    //handle animation
    _animationController._triggerSelectionAnimation(_selected);
  }

  StationData _stationData;

  StationGridEntryWidgetState() {
    _stationData = new StationData.empty();
    _toggledStationButtonCallback = defaultHandler;
  }

  void defaultHandler(StationData s, bool b) {
    print("I am the default handler and I do nothing, probably a problem");
  }

  StationGridEntryWidgetState.fromStationData(StationData stationData,
      ToggledStationButtonCallback toggledStationButtonCallback) {
    _stationData = stationData;
    _toggledStationButtonCallback = toggledStationButtonCallback;
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: _buildAnimationWrappedForStationBox(),
    );
  }

  Widget _buildAnimationWrappedForStationBox() {
    double animatedSize = _animationController.getSizeValue(_selected);
    return new Transform(
      alignment: Alignment.center,
      transform: new Matrix4.diagonal3Values(
        animatedSize,
        animatedSize,
        1.0,
      ),
      child: _buildStationBox(),
    );
  }

  Widget _buildStationBox() {
    Color boxColor = _animationController.getColorValue();

    return new Container(
        child: new Column(
          children: <Widget>[
            new Image.network(_stationData.imageUrl,
                width: 100.0, height: 100.0, fit: BoxFit.cover),
            new Text(_stationData.displayName),
            new Text(_stationData.shortDesc),
          ],
        ),
        decoration: new BoxDecoration(color: boxColor));
  }
}

class StationGridEntryWidgetAnimationController {
  BounceGrowAnimationController _growController;
  BounceShrinkAnimationController _shrinkController;
  ColorChangeAnimationController _colorChangeController;

  Duration animDuration = const Duration(milliseconds: 300);

  void init(State state, TickerProvider tp) {
    initGrowAnim(state, tp);
    initShrinkAnim(state, tp);
    initColorAnim(state, tp);
  }

  void initGrowAnim(State state, TickerProvider tp) {
    _growController =
        new BounceGrowAnimationController(animDuration, tp, state, true);
  }

  void initShrinkAnim(State state, TickerProvider tp) {
    _shrinkController =
        new BounceShrinkAnimationController(animDuration, tp, state, true);
  }

  void initColorAnim(State state, TickerProvider tp) {
    _colorChangeController =
        new ColorChangeAnimationController(animDuration, tp, state, false);
  }

  Color getColorValue() {
    return _colorChangeController.getAnimation().getValue();
  }

  double getSizeValue(bool active) {
    if (active) {
      return _growController.getAnimation().getValue();
    } else {
      return _shrinkController.getAnimation().getValue();
    }
  }

  void _triggerSelectionAnimation(bool active) {
    print("Triggering anim");
    TickerFuture tf; //listener for anim done
    if (active) {
      print("Grow");
      tf = _growController.forward();
      _colorChangeController.forward();
    } else {
      print("Shrink");
      tf = _shrinkController.forward();
      _colorChangeController.reverse();
    }
    tf.whenCompleteOrCancel(() {
      _animDone(active);
    });
  }

  void _animDone(bool active) {
    print("Anim is done : " + active.toString());
  }
}



