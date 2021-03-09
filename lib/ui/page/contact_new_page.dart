/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:';

class ContactNewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: HeaderView(
              expandedHeight: context.heightInPercent(context, 38),
              minHeight: context.widthInPercent(context, 35),
              location: 'Ahmedabad'),
          pinned: true,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin:
                  EdgeInsets.only(top: context.heightInPercent(context, 14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[

                      ]
                    )
                  )
                ]
              )
            )
          ])
        )
      ]
    );
  }
}

class HeaderView extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final String location;

  HeaderView({@required this.expandedHeight, this.minHeight, this.location});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final cardTopPosition = expandedHeight / 1.35 - shrinkOffset;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image(
          image: AssetImage('assets/images/bg_header.png'),
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 16.0, top: 16.0),
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                          fontFamily: 'Arabic',
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top:  16.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            spreadRadius: 5,
                            offset: Offset(0.0, 2)),
                      ],
                      borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(5),
                        topLeft: const Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              BlocProvider.of<LocationBloc>(context)
                                  .add(GetLocationEvent());
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Dimens.Space4,
                                  right: Dimens.Space4,
                                  top: Dimens.Space8,
                                  bottom: Dimens.Space8),
                              child: Row(
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                        'assets/images/ic_location.png'),
                                    width: Dimens.SmallIcon,
                                    height: Dimens.SmallIcon,
                                    color: Palette.colorPrimary,
                                  ),
                                  Text(
                                    location,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: Dimens.Body1,
                                        color: Palette.colorPrimary),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                  visible:
                      (1 - shrinkOffset / expandedHeight) <= 0.8 ? false : true,
                  child: Opacity(
                      opacity: (1 - ((shrinkOffset * 13) / expandedHeight)) <= 0
                          ? 0
                          : (1 - ((shrinkOffset * 13) / expandedHeight)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                16,
                                context.heightInPercent(context, 4),
                                16,
                                0),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 2),
                            padding: EdgeInsets.fromLTRB(
                                0,16, 24.0, 0),
                            child: Text(
                              'hh',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
        Positioned(
          top: cardTopPosition > context.widthInPercent(context, 26)
              ? cardTopPosition
              : context.widthInPercent(context, 26),
          width: context.widthInPercent(context, 100),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin:
                  EdgeInsets.only(left: Dimens.Space16, right: Dimens.Space16),
              child: Opacity(
                  opacity: 1,
                  child: Card(
                      elevation: 4,
                      child: SizedBox(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            width: double.infinity,
                            height: context.heightInPercent(context, 8.5),
                            margin: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 8),
                            child: Text('ff'),
                          )),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ))))),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
*/
