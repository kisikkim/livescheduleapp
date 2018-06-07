import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';

typedef void ToggledStationButtonCallback(StationData stationData, bool newState);

class StationGridEntryWidget extends StatefulWidget {

  final ToggledStationButtonCallback toggledStationButtonCallback;
  final StationData _stationData;

  StationGridEntryWidget(this._stationData, this.toggledStationButtonCallback);

  @override
  StationGridEntryWidgetState createState() => new StationGridEntryWidgetState.fromStationData(_stationData, this.toggledStationButtonCallback);
}

class StationGridEntryWidgetState extends State<StationGridEntryWidget> with TickerProviderStateMixin {


  ToggledStationButtonCallback _toggledStationButtonCallback;


  bool _active = false;




  AnimationController _growController;
  StationSelectionAnimation _animation;


  AnimationController _shrinkController;
  StationSelectionShrinkAnimation _shrinkAnimation;


  @override
  void initState() {
    super.initState();
    _initAnimControllers();
  }

  void _initAnimControllers() {
    _growController = new AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _shrinkController = new AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    //Make an animation controller for selection
    _animation = new StationSelectionAnimation(_growController);
    _shrinkAnimation = new StationSelectionShrinkAnimation(_shrinkController);



    _growController.addStatusListener((status) {
      //when anim is done play it in reverse to revert to original size
      if(status == AnimationStatus.completed) {
        print("Reversing grow");
        _growController.reverse();
      }
    });
    _growController.addListener((){
      setState(() {});
    });

    _shrinkController.addStatusListener((status) {
      //when anim is done play it in reverse to revert to original size
      if(status == AnimationStatus.completed) {
        print("Reversing shrink");
        _shrinkController.reverse();
      }
    });
    _shrinkController.addListener((){
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _growController.dispose();
    _shrinkController.dispose();
  }




  void _handleTap() {
    setState(() {
      _active = !_active;
    });
    if(this._toggledStationButtonCallback != null) {
      this._toggledStationButtonCallback(_stationData, _active);
    } else {
      print("NULL CALLBACK HANDLER FOR " + _stationData.id);
    }



    //handle animation
    _triggerSelectionAnimation(_active);





  }

  StationData _stationData;

  StationGridEntryWidgetState() {
    _stationData = new StationData.empty();
    _toggledStationButtonCallback = defaultHandler;
  }

  void defaultHandler(StationData s, bool b) { print("ping"); }

  StationGridEntryWidgetState.fromStationData(StationData stationData, ToggledStationButtonCallback toggledStationButtonCallback) {
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

    double animatedSize = 0.0;
    if(_active) {
      animatedSize = _animation.avatarSize.value;
    } else {
      animatedSize = _shrinkAnimation.avatarSize.value;
    }


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
    return
      new Container(
        child: new Column(
          children: <Widget>[
            new Image.network(
                _stationData.imageUrl,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover
            ),
            new Text(_stationData.displayName),
            new Text(_stationData.shortDesc),
          ],
        ),
        decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600])
    );
  }

  void _triggerSelectionAnimation(bool active) {




    print("Triggering anim");

    TickerFuture tf;//listner for anim done

    if(active) {
      print("Going to grow");
      print(_animation.avatarSize.value.toString());
      tf = _growController.forward();
    }
    else {
      tf = _shrinkController.forward();
      print(_shrinkAnimation.avatarSize.value.toString());
      print("Going to shrink");
    }
    tf.whenCompleteOrCancel(() {
      _animDone(active);
    });
  }


  void _animDone(bool active) {
    print("Anim is done : " + active.toString());
    if(active) {
      print(_animation.avatarSize.value.toString());
    }
    else {
      print(_shrinkAnimation.avatarSize.value.toString());
    }
  }
}


class StationSelectionAnimation {

  final AnimationController controller;
  Animation<double> avatarSize;

  StationSelectionAnimation(this.controller) {
    avatarSize = new Tween(begin: 1.0, end: 1.2).animate(
      new CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );
  }




//    avatarSize = new Tween(begin: 1.0, end: 1.2).animate(
//    new CurvedAnimation(
//      parent: controller,
//      curve: Curves.elasticIn,
//      ),
//    );
}


class StationSelectionShrinkAnimation {

  final AnimationController controller;
  Animation<double> avatarSize;

  StationSelectionShrinkAnimation(this.controller) {
    avatarSize = new Tween(begin: 1.0, end: 0.8).animate(controller);
//      new CurvedAnimation(
//        parent: controller,
//        curve: Curves.linear,
//      ),
    //);
  }

}
