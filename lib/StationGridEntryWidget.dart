import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  Color _boxColorSelected = Colors.lightGreen[700];
  Color _boxColorUnselected = Colors.grey[600];

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

  Color _boxColorSelected = Colors.lightGreen[700];
  Color _boxColorUnselected = Colors.grey[600];

  void init(State state, TickerProvider tp) {
    initGrowAnim(state, tp);
    initShrinkAnim(state, tp);
    initColorAnim(state, tp);
  }

  void initGrowAnim(State state, TickerProvider tp) {
    _growController =
        new BounceGrowAnimationController(animDuration, tp, state);
  }

  void initShrinkAnim(State state, TickerProvider tp) {
    _shrinkController =
        new BounceShrinkAnimationController(animDuration, tp, state);
  }

  void initColorAnim(State state, TickerProvider tp) {
    _colorChangeController = new ColorChangeAnimationController(
        animDuration, tp, state, _boxColorSelected, _boxColorUnselected);

  }

  Color getColorValue() {
    return _colorChangeController.getColorValue();
  }

  double getSizeValue(bool active) {
    if (active) {
      return _growController.getSizeValue();
    } else {
      return _shrinkController.getSizeValue();
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

//could move a lot of the logic up to a parent class, next step
//class iHRAnimationController extends AnimationController {
//  iHRAnimationController(Duration d, TickerProvider tp, State st, bool autoReverse) : super(duration: d, vsync: tp) {
//
//  }
//}

class BounceGrowAnimationController extends AnimationController {
  BounceGrowAnimation _growAnimation;

  BounceGrowAnimationController(Duration d, TickerProvider tp, State st)
      : super(duration: d, vsync: tp) {
    //Make an animation controller for selection
    _growAnimation = new BounceGrowAnimation(this);
    this.addStatusListener((status) {
      //when anim is done play it in reverse to revert to original size
      if (status == AnimationStatus.completed) {
        print("Reversing grow");
        this.reverse();
      }
    });
    //Need this to cause rebuilds / make anim work
    this.addListener(() {
      st.setState(() {});
    });
  }

  double getSizeValue() {
    return _growAnimation.avatarSize.value;
  }
}

class BounceGrowAnimation {
  final AnimationController controller;
  Animation<double> avatarSize;
  double beginSize = 1.0;
  double endSize = 1.2;

  BounceGrowAnimation(this.controller) {
    avatarSize = new Tween(begin: beginSize, end: endSize).animate(controller);
  }
}

class BounceShrinkAnimationController extends AnimationController {
  BounceShrinkAnimation _animation;

  BounceShrinkAnimationController(Duration d, TickerProvider tp, State st)
      : super(duration: d, vsync: tp) {
    //Make an animation controller for selection
    _animation = new BounceShrinkAnimation(this);
    this.addStatusListener((status) {
      //when anim is done play it in reverse to revert to original size
      if (status == AnimationStatus.completed) {
        print("Reversing shrink");
        this.reverse();
      }
    });
    //Need this to cause rebuilds / make anim work
    this.addListener(() {
      st.setState(() {});
    });
  }

  double getSizeValue() {
    return _animation.avatarSize.value;
  }
}

class BounceShrinkAnimation {
  final AnimationController controller;
  Animation<double> avatarSize;
  double beginSize = 1.0;
  double endSize = 0.8;

  BounceShrinkAnimation(this.controller) {
    avatarSize = new Tween(begin: beginSize, end: endSize).animate(controller);
  }
}

class ColorChangeAnimationController extends AnimationController {
  ColorChangeAnimation _animation;

  ColorChangeAnimationController(
      Duration d, TickerProvider tp, State st, Color start, Color end)
      : super(duration: d, vsync: tp) {
    //Make an animation controller for selection
    _animation = new ColorChangeAnimation(this, start, end);
    this.addStatusListener((status) {
      //don't reverse this one
    });
    //Need this to cause rebuilds / make anim work
    this.addListener(() {
      st.setState(() {});
    });
  }

  Color getColorValue() {
    return _animation.avatarColor.value;
  }
}

class ColorChangeAnimation {
  final AnimationController controller;
  Animation<Color> avatarColor;

  Color boxColorSelected;
  Color boxColorUnselected;

  ColorChangeAnimation(
      this.controller, this.boxColorSelected, this.boxColorUnselected) {
    avatarColor =
        new ColorTween(begin: boxColorUnselected, end: boxColorSelected)
            .animate(controller);
  }
}
