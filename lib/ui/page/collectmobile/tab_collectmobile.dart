import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/ui/widget/dot_tab_indicator.dart';
import 'package:mobex_go/utils/vars.dart';
import 'tab_dispatch.dart';
import 'tab_pick_up.dart';
import 'tab_postpone.dart';

class TabCollectMobile extends StatefulWidget {
  final int id;
  const TabCollectMobile({Key key, this.id}) : super(key: key);

  @override
  _TabCollectMobileState createState() => _TabCollectMobileState(id: id);
}

class _TabCollectMobileState extends State<TabCollectMobile>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController _scrollViewController;
  UserBloc _userBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle tabStyle = TextStyle(fontSize: 16, fontFamily: quickFont);

  int id;
  _TabCollectMobileState({this.id});
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();

    tabController = new TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();

    if (id == 0) {
      tabController.animateTo(id);
    }

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.getLoginDetails();

    myScroll();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (id != 0) {
      tabController.animateTo(id);
    }
  }

  @override
  Widget build(BuildContext context) => _scaffold();

/*
  tabCreate() => CustomScrollView(slivers: <Widget>[
        SliverFillRemaining(
            child: Scaffold(
                //backgroundColor: Colors.white,
                appBar: DecoratedTabBar(
                    tabBar: TabBar(
                        */
/* indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)
                ),*/ /*

                        */
/*indicator: BubbleTabIndicator(
                      indicatorHeight: 40.0,
                      indicatorColor: Colors.deepOrange.shade100,
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    ),*/ /*


                        indicatorColor: Colors.black54,
                        indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.black54),
                            insets: EdgeInsets.symmetric(horizontal: 20.0)),
                        labelColor: Colors.black54,
                        unselectedLabelColor: Colors.grey,
                        controller: tabController,
                        isScrollable: false,
                        tabs: <Widget>[
                          //TODO TAB NAME PICKUP, DISPATCH, POSTPONE
                          _tabName('$tabPickUp'),
                          _tabName('$tabDispatch'),
                          _tabName('$tabPostpone')
                        ]),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2.0,
                          color: Colors.white.withOpacity(0.0),
                        ),
                      ),
                    )),
                body: TabBarView(controller: tabController, children: <Widget>[
                  TabPickUpPage(_userBloc.currentState.id),
                  TabDispatchPage(_userBloc.currentState.id),
                  TabPostPonePage(_userBloc.currentState.id),
                ])))
      ]);
*/

  tabCreate() => NestedScrollView(
      controller: _scrollViewController,
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              /*actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  tooltip: 'Add new entry',
                  onPressed: () {},
                ),
              ],*/
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
              iconTheme: IconThemeData(color: Colors.black),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text('Mobex Go',
                  style: TextStyle(
                      fontFamily: quickFont,
                      fontSize: 18.0,
                      color: Colors.black87)),
              floating: true,
              pinned: true,
              snap: true,
              primary: true,
              forceElevated: false,
              /*flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                      children: <Widget>[Container(color: Colors.white)])),*/
              bottom: TabBar(
                labelColor: Colors.black54,
                unselectedLabelColor: Colors.grey,
                isScrollable: false,
                /* indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1.0, color: Colors.black54),
                    insets: EdgeInsets.symmetric(horizontal: 20.0)),*/
                indicator: DotTabIndicator(
                  indicatorColor: Colors.black54,
                  radius: 2,
                ),
                indicatorWeight: 1 * kDefaultDotIndicatorRadius,
                tabs: <Widget>[
                  _tabName('$tabPickUp'),
                  _tabName('$tabDispatch'),
                  _tabName('$tabPostpone')
                ],
                controller: tabController,
              ))
        ];
      },
      body: SafeArea(
          top: false,
          bottom: false,
          child: TabBarView(controller: tabController, children: [
            TabPickUpPage(_userBloc.currentState.id),
            TabDispatchPage(_userBloc.currentState.id),
            TabPostPonePage(_userBloc.currentState.id),
          ])));

  _scaffold() => CommonScaffold(
      showAppBar: false,
      bodyData: tabCreate(),
      showDrawer: true,
      scaffoldKey: _scaffoldKey,
      actionFirstIcon: null,
      showBottom: true,
      bottomData: isScrollingDown ? null : BottomAppBar(
          elevation: 0.0,
          child: GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.grey.shade200, Colors.white],
                        begin: Alignment.centerRight,
                        end: Alignment(0.0, 0.0),
                        tileMode: TileMode.clamp),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(btnAscHoMobileList,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: quickFont,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))),
              onTap: () =>
                  Navigator.pushNamed(context, mobileRepairAscHoRoute))));

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void myScroll() async {
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
          });

        }
      }
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
          });
        }
      }
    });
  }

  _tabName(String name) => Tab(
          child: Text(
        name,
        style: tabStyle,
      ));
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(child: Container(decoration: decoration)),
      tabBar
    ]);
  }
}
