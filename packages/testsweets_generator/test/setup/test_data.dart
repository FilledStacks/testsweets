const String CodeWithNoKeys = '';

const String CodeWithTwoKeys = '''
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              key: Key('text_counter'),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('touchable_counter'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
''';

const String CodeWithCommentedKeys = '''
Widget build(BuildContext context) {
    const Key key = Key('text_counter');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              // key: Key('text_warning'),
            ),
            Text(
              '',
              key: key,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('touchable_counter'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
''';
const String CodeWithOneKey = '''

class HomeView extends StatelessWidget {
  // ToDo: this will be removed. it is here for the demo.
  final int? index;
  final bool showSuccessBooking;
  final String? entertainerName;

  const HomeView({
    Key? key,
    this.index,
    this.showSuccessBooking = false,
    this.entertainerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = ktsLightGreySmallTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 11.0,
    );
    var scrollController = PrimaryScrollController.of(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(index ?? 0),
      onModelReady: (model) => model.initializeFirebaseMessaging(),
      builder: (context, model, child) {
        return Scaffold(
            key: Key("home_view"),
            body: PageTransition(
              reverse: model.reverse,
              child: _GetViewForIndex(
                index: model.currentIndex,
                showSuccessBooking: showSuccessBooking,
                entertainerName: entertainerName,
                controller: scrollController,
              ),
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(
                brightness: Brightness.light,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: GestureDetector(
                onDoubleTap: () {
                  if (model.currentIndex == 0) {
                    scrollController!.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.linear,
                    );
                  }
                },
                child: model.hasUser
                    ? BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: model.currentIndex,
                        backgroundColor: kcLightBlueBlack,
                        onTap: model.setIndex,
                        iconSize: 26.0,
                        selectedItemColor: kcPrimaryColor,
                        unselectedItemColor: kcLightBlue,
                        unselectedLabelStyle: textStyle,
                        selectedLabelStyle: textStyle,
                        items: [
                          bottomNavigationBarItem(
                            label: 'Home',
                            asset:
                                'assets/lottie/bottom_navigation_bar/home_icon.json',
                            isActive: model.isIndexSelected(0),
                          ),
                          if (model.hasAccount)
                            bottomNavigationBarItem(
                              label: 'Bookings',
                              asset:
                                  'assets/lottie/bottom_navigation_bar/booking_icon.json',
                              isActive: model.isIndexSelected(1),
                            ),
                          bottomNavigationBarItem(
                            label: 'Account',
                            asset:
                                'assets/lottie/bottom_navigation_bar/account_icon.json',
                            isActive: model.isIndexSelected(2),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ),
            bottomSheet:
                model.hasUser ? SizedBox.shrink() : CustomBottomSheet());
      },
    );
  }


''';
const String CodeWithTwoKeysThatHaveNewLine = '''

class ServiceLocationNoticeView extends StatelessWidget {
  const ServiceLocationNoticeView({Key? viewKey, Key? takeMeToAppKey})
      : super(key: viewKey);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ServiceLocationServiceViewModel>.reactive(
        viewModelBuilder: () => ServiceLocationServiceViewModel(),
        builder: (context, model, child) => Scaffold(
              key: Key('serviceLocationNotice_view'),
              backgroundColor: kcLightBlueBlack,
              body: SafeArea(
                  child: Padding(
                padding: appSymmetricEdgePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceMassive,
                    Text(
                      "We're only in Chattanooga",
                      style: ktsWhiteLargTextStyle.copyWith(fontSize: 30),
                    ),
                    verticalSpaceSmall16,
                    Text(
                      "We're expanding soon. Let us know if you'd like us to come to your city next.",
                      style: ktsWhiteBodyTextStyle.copyWith(fontSize: 15),
                    ),
                    Expanded(child: Container()),
                    ExpandingAppButton(
                        key: Key(
                            'serviceLocationNotice_touchable_takeMeToTheApp'),
                        title: "Great, take me to the app",
                        onTap: model.onTakeMetoTheAppTap),
                    verticalSpaceSmall16,
               );
  }
}
''';
