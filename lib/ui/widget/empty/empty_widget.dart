import 'dart:math';
import 'package:flutter/material.dart';
import 'helper.dart';
import 'utility.dart';

class EmptyListWidget extends StatefulWidget {
  EmptyListWidget(
      {this.title,
      this.subTitle,
      this.image,
      this.subtitleTextStyle,
      this.titleTextStyle});

  final String image;
  final String subTitle;
  final TextStyle subtitleTextStyle;
  final String title;
  final TextStyle titleTextStyle;

  @override
  State<StatefulWidget> createState() => _EmptyListWidgetState();
}

class _EmptyListWidgetState extends State<EmptyListWidget> with TickerProviderStateMixin {
  AnimationController _backgroundController;
  Animation _imageAnimation;
  AnimationController _imageController;
  TextStyle _subtitleTextStyle;
  TextStyle _titleTextStyle;
  AnimationController _widgetController;

  @override
  void dispose() {
    _backgroundController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _backgroundController = AnimationController(
        duration: const Duration(minutes: 1),
        vsync: this,
        lowerBound: 0,
        upperBound: 20)
      ..repeat();
    _widgetController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        lowerBound: 0,
        upperBound: 1)
      ..forward();
    _imageController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _imageAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.linear),
    );
    super.initState();
  }

  animationListner() {
    if (_imageController == null) {
      return;
    }
    if (_imageController.isCompleted) {
      setState(() {
        _imageController.reverse();
      });
    } else {
      setState(() {
        _imageController.forward();
      });
    }
  }

  Widget _imageWidget() {
    return Expanded(
      flex: 3,
      child: AnimatedBuilder(
          animation: _imageAnimation,
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                offset: Offset(
                    0,
                    sin(_imageAnimation.value > .9
                        ? 1 - _imageAnimation.value
                        : _imageAnimation.value)),
                child: child);
          },
          child: Image.asset(
            'assets/images/mobex_go.png',
            color: Colors.deepOrange.shade300,
          )),
    );
  }

  Widget _imageBackground() {
    return Container(
      width: EmptyWidgetUtility.getHeightDimention(
          context, EmptyWidgetUtility.fullWidth(context) * .95),
      height: EmptyWidgetUtility.getHeightDimention(
          context, EmptyWidgetUtility.fullWidth(context) * .95),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 0),
          color: Colors.grey.shade100,
        ),
        BoxShadow(
            blurRadius: 30,
            offset: Offset(20, 0),
            color: Colors.white,
            spreadRadius: -5),
      ], shape: BoxShape.circle),
    );
  }

  Widget _shell({Widget child}) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxHeight > constraints.maxWidth) {
        return Container(
          height: constraints.maxWidth,
          width: constraints.maxWidth,
          child: child,
        );
      } else {
        return child;
      }
    });
  }

  Widget _shellChild() {
    _titleTextStyle = widget.titleTextStyle ??
        Theme.of(context)
            .typography
            .dense
            .display1
            .copyWith(color: Color(0xff9da9c7));
    _subtitleTextStyle = widget.subtitleTextStyle ??
        Theme.of(context)
            .typography
            .dense
            .body2
            .copyWith(color: Color(0xffabb8d6));

    return FadeTransition(
      opacity: _widgetController,
      child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            RotationTransition(
              child: _imageBackground(),
              turns: _backgroundController,
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  height: constraints.maxWidth,
                  width: constraints.maxWidth - 30,
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        _imageWidget(),
                        Column(children: <Widget>[
                          CustomText(
                            msg: widget.title,
                            style: _titleTextStyle,
                            context: context,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                              msg: widget.subTitle,
                              style: _subtitleTextStyle,
                              context: context,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center)
                        ]),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        )
                      ]));
            })
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _shell(child: _shellChild());
  }
}
