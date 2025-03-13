class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool addStory;

  PageConfiguration.splash()
    : unknown = false,
      register = false,
      loggedIn = null,
      storyId = null,
      addStory = false;

  PageConfiguration.login()
    : unknown = false,
      register = false,
      loggedIn = false,
      storyId = null,
      addStory = false;

  PageConfiguration.register()
    : unknown = false,
      register = true,
      loggedIn = false,
      storyId = null,
      addStory = false;

  PageConfiguration.home()
    : unknown = false,
      register = false,
      loggedIn = true,
      storyId = null,
      addStory = false;

  PageConfiguration.detailStory(String id)
    : unknown = false,
      register = false,
      loggedIn = true,
      storyId = id,
      addStory = false;

  PageConfiguration.addStory()
    : unknown = false,
      register = false,
      loggedIn = false,
      storyId = null,
      addStory = true;

  PageConfiguration.unknown()
    : unknown = true,
      register = false,
      loggedIn = null,
      storyId = null,
      addStory = false;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      storyId == null &&
      addStory == false;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storyId == null &&
      addStory == false;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      storyId == null &&
      addStory == false;

  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null &&
      addStory == false;

  bool get isDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId != null &&
      addStory == false;

  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      storyId == null &&
      addStory == false;

  bool get isAddStoryPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storyId == null &&
      addStory == true;
}
