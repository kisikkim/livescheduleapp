import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

abstract class iHRAnimationController<Q extends iHRAnimationWrapper>
    extends AnimationController {
  Q _animation;

  iHRAnimationController(
      Duration d, TickerProvider tp, State st, bool autoReverse)
      : super(duration: d, vsync: tp) {
    makeAnim();
    setListeners(st, autoReverse);
  }

  //TECH DEBT: Can't figure out how to use the generics properly to not need this call.....
  void makeAnim() {}

  void makeAnimPassValues(double s, double e) {}

  void setListeners(State st, bool autoReverse) {
    if (autoReverse) {
      this.addStatusListener((status) {
        //when anim is done play it in reverse
        if (status == AnimationStatus.completed) {
          this.reverse();
        }
      });
    }
    //Need this to cause rebuilds / make anim work
    this.addListener(() {
      st.setState(() {});
    });
  }

  Q getAnimation() {
    return _animation;
  }

//More generics, should set this up but not sure syntax
//Q getValue();

}

class GenericAnimationController
    extends iHRAnimationController<GenericAnimation> {
  GenericAnimationController(Duration d, TickerProvider tp, State st,
      bool autoReverse, double start, double end)
      : super(d, tp, st, autoReverse) {
    makeAnimPassValues(start, end);
  }

  @override
  void makeAnimPassValues(double start, double end) {
    _animation = new GenericAnimation(this, start, end);
  }
}

class GenericCurvesAnimationController
    extends iHRAnimationController<GenericAnimation> {
  GenericCurvesAnimationController(Duration d, TickerProvider tp, State st,
      bool autoReverse, double start, double end)
      : super(d, tp, st, autoReverse) {
    makeAnimPassValues(start, end);
  }

  @override
  void makeAnimPassValues(double start, double end) {
    _animation = new GenericAnimation(this, start, end);
  }
}

class BounceGrowAnimationController
    extends iHRAnimationController<BounceGrowAnimation> {
  BounceGrowAnimationController(
      Duration d, TickerProvider tp, State st, bool autoReverse)
      : super(d, tp, st, autoReverse) {}

  @override
  void makeAnim() {
    _animation = new BounceGrowAnimation(this);
  }
}

class BounceShrinkAnimationController
    extends iHRAnimationController<BounceShrinkAnimation> {
  BounceShrinkAnimationController(
      Duration d, TickerProvider tp, State st, bool autoReverse)
      : super(d, tp, st, autoReverse) {}

  @override
  void makeAnim() {
    _animation = new BounceShrinkAnimation(this);
  }
}

class ColorChangeAnimationController
    extends iHRAnimationController<ColorChangeAnimation> {
  ColorChangeAnimationController(
      Duration d, TickerProvider tp, State st, bool autoReverse)
      : super(d, tp, st, autoReverse) {}

  @override
  void makeAnim() {
    _animation = new ColorChangeAnimation(this);
  }
}

class OpacityChangeAnimationController
    extends iHRAnimationController<OpacityChangeAnimation> {
  OpacityChangeAnimationController(
      Duration d, TickerProvider tp, State st, bool autoReverse)
      : super(d, tp, st, autoReverse) {}

  @override
  void makeAnim() {
    _animation = new OpacityChangeAnimation(this);
  }
}

abstract class iHRAnimationWrapper<T> {
  iHRAnimationWrapper(this.controller);

  final iHRAnimationController controller;
  Animation<T> _animation;

  T getValue() {
    return _animation.value;
  }
}

class BounceGrowAnimation extends iHRAnimationWrapper<double> {
  double beginSize = 1.0;
  double endSize = 1.2;

  BounceGrowAnimation(controller) : super(controller) {
    _animation = new Tween(begin: beginSize, end: endSize).animate(controller);
  }
}

class BounceShrinkAnimation extends iHRAnimationWrapper<double> {
  double beginSize = 1.0;
  double endSize = 0.8;

  BounceShrinkAnimation(controller) : super(controller) {
    _animation = new Tween(begin: beginSize, end: endSize).animate(controller);
  }
}

class ColorChangeAnimation extends iHRAnimationWrapper<Color> {
  Color boxColorSelected = Colors.lightBlue[100];
  Color boxColorUnselected = Colors.grey[200];

  ColorChangeAnimation(controller) : super(controller) {
    _animation =
        new ColorTween(begin: boxColorUnselected, end: boxColorSelected)
            .animate(controller);
  }
}

class OpacityChangeAnimation extends iHRAnimationWrapper<double> {
  double beginOpacity = 1.0;
  double endOpacity = 0.0;

  OpacityChangeAnimation(controller) : super(controller) {
    _animation =
        new Tween(begin: beginOpacity, end: endOpacity).animate(controller);
  }
}

class GenericAnimation extends iHRAnimationWrapper<double> {
  double start = 0.0;
  double end = 1.0;

  GenericAnimation(controller, this.start, this.end) : super(controller) {
    _animation = new Tween(begin: start, end: end).animate(controller);
  }
}

class GenericCurveAnimation extends iHRAnimationWrapper<double> {
  double start = 0.0;
  double end = 1.0;

  GenericCurveAnimation(controller, this.start, this.end) : super(controller) {
    _animation = new Tween(begin: start, end: end).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.100,
          0.400,
          curve: Curves.elasticOut,
        ),
      ),
    );
  }
}
