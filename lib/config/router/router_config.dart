import 'package:go_router/go_router.dart';

enum RouterPage {
  /// Page
  root('/', '/', '/'),
  home('home', 'home', '/home');

  final String routerName;
  final String routerPath;
  final String navPath;

  const RouterPage(
    this.routerName,
    this.routerPath,
    this.navPath,
  );
}

List<RouteBase> routes = [
  GoRoute(
      name: RouterPage.root.routerName,
      path: RouterPage.root.routerName,
      builder: (context, params) => const SplashPage(),
      routes: [
        ShellRoute(
            navigatorKey: tabNavigatorKey,
            builder: (context, state, child) {
              return FxBottomNav(child: child);
            },
            routes: [
              /// HOME PAGE
              _homeRouter,
              _roidRouter,
              _logRouter,
            ]
        ),
        /// ERROR, CUSTOM PAGES (APP - ROOT)
        ..._rootCustomPage,
        /// END ERROR, CUSTOM PAGES (APP - ROOT)

        /// DIALOG, MODAL, BOTTOM SHEET (APP - ROOT)
        ..._rootMisc,
        /// END DIALOG, MODAL, BOTTOM SHEET (APP - ROOT)

        /// GREETING PAGE
        _greetingRouter,

        /// AUTH PAGE
        _authRouter,

        /// GIFT PAGE
        _giftRouter,

        /// PURCHASE PAGE
        _purchaseRouter,

        /// IMAGE VIEW DETAIL PAGE
        _imagePreviewRouter,
      ]
  ),
];

/**
 * ? _rootCustomPageRouter
 * * Contain:
 * NotFoundPage
 * NotFoundArticle
 */
List<GoRoute> get _rootCustomPage => [
  GoRoute(
    name: RouterPage.notFoundPage.routerName,
    path: RouterPage.notFoundPage.routerPath,
    builder: (context, params) => const NotFoundPage(),
    redirect: (context, params) => RouterPage.home.navPath,
  ),

  GoRoute(
    name: RouterPage.notFoundArticle.routerName,
    path: RouterPage.notFoundArticle.routerPath,
    builder: (context, params) => const NotFoundArticle(),
  ),
];

/**
 * ? _rootMiscRouter
 * * Contain:
 * TermPolicyBottomSheet
 * NetworkNotFoundDialog
 * DeficiencyCubeDialog
 * PurchaseCubeDialog
 * InvalidCubeDialog
 * ConfirmationReTestEneGraphDialog
 */
List<GoRoute> get _rootMisc => [
  GoRoute(
      path: RouterPage.termPolicyBottomSheet.routerPath,
      pageBuilder: (context, params) {
        return FxBottomSheetPage(
          builder: (_) => TermPolicyBottomSheet(data: params.extraMap['data']),
          barrierLabel: RouterPage.termPolicyBottomSheet.routerName,
          isScrollControlled: true,
          clipBehavior: Clip.antiAlias,
          isDismissible: false,
        );
      }
  ),

  GoRoute(
      path: RouterPage.notConnectNetworkDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const NetworkNotFoundDialog(),
          barrierLabel: RouterPage.notConnectNetworkDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.insufficientCubeDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => DeficiencyCubeDialog(chapter: params.extraMap['chapter'],
              totalCube: params.extraMap['totalCube'], chapterPos: params.extraMap['chapterPos']),
          barrierLabel: RouterPage.insufficientCubeDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.purchaseCubeDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => PurchaseCubeDialog(isSuccess: params.extraMap['isSuccess']),
          barrierLabel: RouterPage.purchaseCubeDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.invalidCubeDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const InvalidCubeDialog(),
          barrierLabel: RouterPage.invalidCubeDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.reTestEneGraphDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => ConfirmationReTestEneGraphDialog(lastTestDate: params.extraMap['lastTestDate']),
          barrierLabel: RouterPage.reTestEneGraphDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.remindEneGraphDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const RemindEneGraphDialog(),
          barrierLabel: RouterPage.remindEneGraphDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.confirmationChapterHistoryLoadDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => ConfirmationChapterHistoryLoadDialog(readStatus: params.extraMap['readStatus']),
          barrierLabel: RouterPage.confirmationChapterHistoryLoadDialog.routerName,
        );
      }
  ),
];

/**
 * ? _homeRouter
 * * Contain:
 * HomePage
 * _homeMiscRouter
 * _contentRouter
 * _chapterRouter
 * _eneGreetingRouter
 */
GoRoute get _homeRouter => GoRoute(
    name: RouterPage.home.routerName,
    path: RouterPage.home.routerPath,
    builder: (context, params) => HomePage(
      checkRouter: params.extraMap['checkRouter'],
    ),
    routes: [
      /// DIALOG, MODAL, BOTTOM SHEET (HOME)
      ..._homeMisc,
      /// END DIALOG, MODAL, BOTTOM SHEET (HOME)

      /// CONTENT PAGE
      _contentRouter,

      /// CHAPTER PAGE
      _chapterRouter,

      /// ENE GRAPH PAGE
      _eneGreetingRouter,
    ]
);

/**
 * ? _homeMiscRouter
 * * Contain:
 * HomeDialog
 * AppVersionUpdateDialog
 */
List<GoRoute> get _homeMisc => [
  GoRoute(
      path: RouterPage.homeDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => HomeDialog(popups: params.extraMap['popups']),
          barrierLabel: RouterPage.homeDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.appVersionUpdateDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => AppVersionUpdateDialog(storePath: params.extraMap['storePath']),
          barrierLabel: RouterPage.appVersionUpdateDialog.routerName,
        );
      }
  ),
];

/**
 * ? _contentRouter
 * * Contain:
 * ContentPage
 */
GoRoute get _contentRouter => GoRoute(
  name: RouterPage.content.routerName,
  path: RouterPage.content.routerPath,
  builder: (context, params) {
    return ContentPage(
      typeName: params.extraMap['typeName']!,
      serverType: params.extraMap['serverType']!,
    );
  },
);
GoRoute get _roidoInfoRouter => GoRoute(
  name: RouterPage.roidoInfo.routerName,
  path: RouterPage.roidoInfo.routerPath,
  builder: (context, params) {
    return RoidInfoPage(
        id: params.pathParameters['id']
    );
  },
);

/**
 * ? _chapterRouter
 * * Contain:
 * ChapterPage
 * _chapterMiscRouter
 * _conversationRouter
 * _listChapterRouter
 */
GoRoute get _chapterRouter => GoRoute(
    name: RouterPage.chapter.routerName,
    path: RouterPage.chapter.routerPath,
    builder: (context, params) => ChapterPage(
      contentId: params.pathParameters['contentId'],
      serverType: params.extraMap['serverType']!,
    ),
    routes: [
      /// DIALOG, MODAL, BOTTOM SHEET (CHAPTER)
      ..._chapterMisc,
      /// END DIALOG, MODAL, BOTTOM SHEET (CHAPTER)

      /// CONVERSATION PAGE
      _conversationRouter,

      /// LIST CHAPTER PAGE
      _listChapterRouter,
    ]
);

/**
 * ? _chapterMiscRouter
 * * Contain:
 * ChapterBannerDialog
 * ChapterDescriptionBottomSheet
 */
List<GoRoute> get _chapterMisc => [
  GoRoute(
      path: RouterPage.chapterBannerDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => ChapterBannerDialog(chapters: params.extraMap['chapters']),
          barrierLabel: RouterPage.chapterBannerDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.chapterDescriptionBottomSheet.routerPath,
      pageBuilder: (context, params) {
        return FxBottomSheetPage(
          builder: (_) => ChapterDescriptionBottomSheet(description: params.extraMap['description']),
          barrierLabel: RouterPage.chapterDescriptionBottomSheet.routerName,
          isScrollControlled: true,
          clipBehavior: Clip.antiAlias,
        );
      }
  ),
];

/**
 * ? _conversationRouter
 * * Contain:
 * ConversationPage
 * _conversationMiscRouter
 */
GoRoute get _conversationRouter => GoRoute(
    name: RouterPage.conversation.routerName,
    path: RouterPage.conversation.routerPath,
    builder: (context, params) {
      return ConversationPage(
        chapterId: params.pathParameters['chapterId']!,
        serverType: params.extraMap['serverType']!,
        formHistoryIndex: params.extraMap['formHistoryIndex'],
        reInitDataInputs: params.extraMap['reInitDataInputs'],
        reOpen: params.extraMap['reOpen'],
        fromType: params.extraMap['fromType'] ?? 'normal',
      );
    },
    routes: [
      /// DIALOG, MODAL, BOTTOM SHEET (CONVERSATION)
      ..._conversationMisc,
      /// END DIALOG, MODAL, BOTTOM SHEET (CONVERSATION)
    ]
);

/**
 * ? _conversationMiscRouter
 * * Contain:
 * SaveConfirmDialog
 */
List<GoRoute> get _conversationMisc => [
  GoRoute(
      path: RouterPage.saveConfirmDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const SaveConfirmDialog(),
          barrierLabel: RouterPage.saveConfirmDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.confirmationRecordDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const ConfirmationRecordDialog(),
          barrierLabel: RouterPage.confirmationRecordDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.confirmationShareDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const ConfirmationShareDialog(),
          barrierLabel: RouterPage.confirmationShareDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.checkPermissionDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const CheckPermissionDialog(),
          barrierLabel: RouterPage.checkPermissionDialog.routerName,
        );
      }
  ),
];

/**
 * ? _listChapterRouter
 * * Contain:
 * ChapterTotalWidget
 */
GoRoute get _listChapterRouter => GoRoute(
  name: RouterPage.listChapter.routerName,
  path: RouterPage.listChapter.routerPath,
  builder: (context, params) => ChapterTotalWidget(
    contentId: params.pathParameters['contentId']!,
    isTool: params.extraMap['isTool'],
    deviceId: params.extraMap['deviceId']!,
    serverType: params.extraMap['serverType'],
  ),
);

/**
 * ? _eneGreetingRouter
 * * Contain:
 * EnecolorGreetingPage
 */
GoRoute get _eneGreetingRouter => GoRoute(
  name: RouterPage.eneGraph.routerName,
  path: RouterPage.eneGraph.routerPath,
  builder: (context, params) => const EnecolorGreetingPage(),
);

/**
 * ? _roidRouter
 * * Contain:
 * RoidoPage
 * _roidMiscRouter
 * _roidoInfoRouter
 */
GoRoute get _roidRouter => GoRoute(
    name: RouterPage.roido.routerName,
    path: RouterPage.roido.routerPath,
    builder: (context, params) => RoidoPage(
      bgColor: params.extraMap['bgColor'],
    ),
    routes: [
      /// DIALOG, MODAL, BOTTOM SHEET (HOME)
      ..._roidMisc,
      /// END DIALOG, MODAL, BOTTOM SHEET (HOME)
      _roidoInfoRouter
    ]
);

/**
 * ? _roidMiscRouter
 * * Contain:
 */
List<GoRoute> get _roidMisc => [];

/**
 * ? _logRouter
 * * Contain:
 * RoidoPage
 */
GoRoute get _logRouter => GoRoute(
  name: RouterPage.log.routerName,
  path: RouterPage.log.routerPath,
  builder: (context, params) => RoidoPage(
    bgColor: params.extraMap['bgColor'],
  ),
);

/**
 * ? _greetingRouter
 * * Contain:
 * GreetingPage
 */
GoRoute get _greetingRouter => GoRoute(
  name: RouterPage.greeting.routerName,
  path: RouterPage.greeting.routerPath,
  builder: (context, params) => const GreetingPage(),
);

/**
 * ? _authRouter
 * * Contain:
 * AuthPage
 * _authMiscRouter
 * _eneHistoryRouter
 */
GoRoute get _authRouter => GoRoute(
  name: RouterPage.auth.routerName,
  path: RouterPage.auth.routerPath,
  builder: (context, params) => const AuthPage(),
  routes: [
    /// DIALOG, MODAL, BOTTOM SHEET (AUTH)
    ..._authMisc,
    /// END DIALOG, MODAL, BOTTOM SHEET (AUTH)

    /// ENE HISTORY PAGE
    _eneHistoryRouter,
  ],
);

/**
 * ? _authMiscRouter
 * * Contain:
 * FeedBackDialog
 * FeedBackSuccessDialog
 * ChatGptSettingDialog
 */
List<GoRoute> get _authMisc => [
  GoRoute(
      path: RouterPage.feedBackDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const FeedBackDialog(),
          barrierLabel: RouterPage.feedBackDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.feedBackSuccessDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => const FeedBackSuccessDialog(),
          barrierLabel: RouterPage.feedBackSuccessDialog.routerName,
        );
      }
  ),

  GoRoute(
      path: RouterPage.chatGptSettingDialog.routerPath,
      pageBuilder: (context, params) {
        return FxDialogPage(
          builder: (_) => ChatGptSettingDialog(
            any: params.extraMap['any'],
            gptPackages: params.extraMap['gptPackages'],
          ),
          barrierLabel: RouterPage.chatGptSettingDialog.routerName,
        );
      }
  ),
];

/**
 * ? _eneHistoryRouter
 * * Contain:
 * EneGraphHistoryPage
 * _eneGraphHistoryDetailRouter
 */
GoRoute get _eneHistoryRouter => GoRoute(
  name: RouterPage.history.routerName,
  path: RouterPage.history.routerPath,
  builder: (context, params) => const EneGraphHistoryPage(),
  routes: [
    /// ENE HISTORY DETAIL PAGE
    _eneGraphHistoryDetailRouter,
  ],
);

/**
 * ? _eneGraphHistoryDetailRouter
 * * Contain:
 * EneGraphHistoryDetailPage
 */
GoRoute get _eneGraphHistoryDetailRouter => GoRoute(
  name: RouterPage.historyDetail.routerName,
  path: RouterPage.historyDetail.routerPath,
  builder: (context, params) => EneGraphHistoryDetailPage(history: params.allParams['history']),
);

/**
 * ? _giftRouter
 * * Contain:
 * GiftPage
 * ChapterBannerDialog
 * LackCubeDialog
 * SendCubeGiftDialog
 * SendCubeGiftSuccessDialog
 */
GoRoute get _giftRouter => GoRoute(
    name: RouterPage.gift.routerName,
    path: RouterPage.gift.routerPath,
    builder: (context, params) => GiftPage(contentId: params.extraMap['contentId'], serverType: params.extraMap['serverType']),
    routes: [
      /// DIALOG, MODAL, BOTTOM SHEET (GIFT)
      GoRoute(
          path: RouterPage.giftBannerDialog.routerPath,
          pageBuilder: (context, params) {
            return FxDialogPage(
              builder: (_) => ChapterBannerDialog(chapters: params.extraMap['chapters']),
              barrierLabel: RouterPage.giftBannerDialog.routerName,
            );
          }
      ),

      GoRoute(
          path: RouterPage.lackCubeDialog.routerPath,
          pageBuilder: (context, params) {
            return FxDialogPage(
              builder: (_) => const LackCubeDialog(),
              barrierLabel: RouterPage.lackCubeDialog.routerName,
            );
          }
      ),

      GoRoute(
          path: RouterPage.sendCubeGiftDialog.routerPath,
          pageBuilder: (context, params) {
            return FxDialogPage(
              builder: (_) => SendCubeGiftDialog(
                ownCube: params.extraMap['ownCube'],
                userId: params.extraMap['userId'],
                chapterId: params.extraMap['chapterId'],
              ),
              barrierLabel: RouterPage.sendCubeGiftDialog.routerName,
            );
          }
      ),

      GoRoute(
          path: RouterPage.sendCubeGiftSuccessDialog.routerPath,
          pageBuilder: (context, params) {
            return FxDialogPage(
              builder: (_) => const SendCubeGiftSuccessDialog(),
              barrierLabel: RouterPage.sendCubeGiftSuccessDialog.routerName,
            );
          }
      ),
      /// END DIALOG, MODAL, BOTTOM SHEET (GIFT)
    ]
);

/**
 * ? _purchaseRouter
 * * Contain:
 * PurchasePage
 * _premiumPlanRouter
 */
GoRoute get _purchaseRouter => GoRoute(
    name: RouterPage.purchase.routerName,
    path: RouterPage.purchase.routerPath,
    builder: (context, params) => const PurchasePage(),
    routes: [
      /// PREMIUM PLAN PAGE
      _premiumPlanRouter,
    ]
);

/**
 * ? _premiumPlanRouter
 * * Contain:
 * PremiumPlanPage
 */
GoRoute get _premiumPlanRouter => GoRoute(
  name: RouterPage.premiumPlan.routerName,
  path: RouterPage.premiumPlan.routerPath,
  builder: (context, params) => const PremiumPlanPage(),
);

/**
 * ? _imagePreviewRouter
 * * Contain:
 * ImagePreviewWidget
 */
GoRoute get _imagePreviewRouter => GoRoute(
  name: RouterPage.imagePreview.routerName,
  path: RouterPage.imagePreview.routerPath,
  builder: (context, params) => ImagePreviewWidget(
    imageUrl: params.extraMap['imageUrl'],
  ),
);