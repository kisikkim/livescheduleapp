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

//
//  AnimationController _growController;
//  StationSelectionAnimation _growAnimation;
//
//
//  AnimationController _shrinkController;
//  StationSelectionShrinkAnimation _shrinkAnimation;
//
//  AnimationController _colorChangeController;
//  StationSelectionColorChangeAnimation _colorChangeAnimation;

  StationGridEntryWidgetAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new StationGridEntryWidgetAnimationController();
    _animationController.init(this, this);

    //_animationController._growController.addListener() { setState(() {});

//    _animationController._growController.addListener((){
//      setState(() {});
//    });

    //_initAnimControllers();
  }

//  void _initAnimControllers() {
//    _growController = new AnimationController(
//      duration: const Duration(milliseconds: 300),
//      vsync: this,
//    );
//
//    _shrinkController = new AnimationController(
//      duration: const Duration(milliseconds: 300),
//      vsync: this,
//    );
//
//    _colorChangeController = new AnimationController(
//      duration: const Duration(milliseconds: 300),
//      vsync: this,
//    );
//
//    //Make an animation controller for selection
//    _growAnimation = new StationSelectionAnimation(_growController);
//    _shrinkAnimation = new StationSelectionShrinkAnimation(_shrinkController);
//    _colorChangeAnimation = new StationSelectionColorChangeAnimation(_colorChangeController, _boxColorSelected, _boxColorUnselected);
//
//
//
//    _growController.addStatusListener((status) {
//      //when anim is done play it in reverse to revert to original size
//      if(status == AnimationStatus.completed) {
//        print("Reversing grow");
//        _growController.reverse();
//      }
//    });
//    _growController.addListener((){
//      setState(() {});
//    });
//
//    _shrinkController.addStatusListener((status) {
//      //when anim is done play it in reverse to revert to original size
//      if(status == AnimationStatus.completed) {
//        print("Reversing shrink");
//        _shrinkController.reverse();
//      }
//    });
//    _shrinkController.addListener((){
//      setState(() {});
//    });
//  }

//  @override
//  void dispose() {
//    super.dispose();
//    _growController.dispose();
//    _shrinkController.dispose();
//    _colorChangeController.dispose();
//  }

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
    print("ping");
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
  //BounceGrowAnimation _growAnimation;

  AnimationController _shrinkController;
  BounceShrinkAnimation _shrinkAnimation;

  AnimationController _colorChangeController;
  ColorChangeAnimation _colorChangeAnimation;

  Duration animDuration = const Duration(milliseconds: 300);

  Color _boxColorSelected = Colors.lightGreen[700];
  Color _boxColorUnselected = Colors.grey[600];

  void init(State state, TickerProvider tp) {
    initGrowAnim(state, tp);
    initShrinkAnim(state, tp);
    initColorAnim(state, tp);
  }

  void initGrowAnim(State state, TickerProvider tp) {
    _growController = new BounceGrowAnimationController(animDuration, tp, state);

  }

  void initShrinkAnim(State state, TickerProvider tp) {
    _shrinkController = new AnimationController(
      duration: animDuration,
      vsync: tp,
    );

    _shrinkAnimation = new BounceShrinkAnimation(_shrinkController);
    _shrinkController.addStatusListener((status) {
      //when anim is done play it in reverse to revert to original size
      if (status == AnimationStatus.completed) {
        print("Reversing shrink");
        _shrinkController.reverse();
      }
    });
    //Need this to cause rebuilds / make anim work
    _shrinkController.addListener(() {
      state.setState(() {});
    });
  }

  void initColorAnim(State state, TickerProvider tp) {
    _colorChangeController = new AnimationController(
      duration: animDuration,
      vsync: tp,
    );

    //Color anim doesn't need to trigger setStates it seems?
    _colorChangeAnimation = new ColorChangeAnimation(
        _colorChangeController, _boxColorSelected, _boxColorUnselected);
  }

  Color getColorValue() {
    return _colorChangeAnimation.avatarColor.value;
  }

  double getSizeValue(bool active) {
    if (active) {
      return _growController.getSizeValue();
    } else {
      return _shrinkAnimation.avatarSize.value;
    }
  }

  void _triggerSelectionAnimation(bool active) {
    print("Triggering anim");
    TickerFuture tf; //listner for anim done
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


//class iHRAnimationController extends AnimationController {
//  iHRAnimationController(Duration d, TickerProvider tp, State st, bool autoReverse) : super(duration: d, vsync: tp) {
//
//  }
//}


class BounceGrowAnimationController extends AnimationController {

  BounceGrowAnimation _growAnimation;

  BounceGrowAnimationController(Duration d, TickerProvider tp, State st) : super(duration: d, vsync: tp) {
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

class BounceShrinkAnimation {
  final AnimationController controller;
  Animation<double> avatarSize;
  double beginSize = 1.0;
  double endSize = 0.8;

  BounceShrinkAnimation(this.controller) {
    avatarSize = new Tween(begin: beginSize, end: endSize).animate(controller);
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
