class Routes {
  // Singleton instance
  static final Routes _instance = Routes._internal();

  // Private constructor
  Routes._internal();

  // Factory constructor to return the same instance
  factory Routes() {
    return _instance;
  }

  // Static route constants
  static const String registerView = '/register';
  static const String loginView = '/login';
  static const String homeView = '/home';
  static const String layoutView = '/layout';
  static const String forgotPasswordView = '/forgot-password';
  static const String reelsView = '/reels';
  static const String tvView = '/tv';
  static const String pdfView = '/pdf';
  static const String articalsCategorySectionView = '/articals-section';
  static const String detailsArticalView = '/details-artical';
  static const String detailsGalleryView = '/details-gallery';
  static const String searchView = '/search';
  static const String searchCategoryView = '/search-category';
  static const String alThawraArchiveView = '/al-thawra-archive';
  static const String archivePdfView = '/search-pdf';
  static const String profileView = '/profile';
  static const String favoritesView = '/favorites';
  static const String editInfoView = '/edit-info';
  static const String splashView = '/splash';
  static const String drawerSubCategoryContent = '/drawerSubCategoryContent';
  static const String aboutUsView = '/about-us';
  static const String privacyPolicyView = '/privacy-policy';
  static const String contactUsView = '/contact-us';
  static const String videoDetailsView = '/video-details';
  static const String audioMagazineView = '/audio-magazines';
  static const String audioBookDetails = '/audio-book-details';
  static const String audioPlayerView = '/audio-player';
  static const String authorProfileView = '/author-profile';
  static const String galleriesArticlesWidget = '/galleries-articles-widget';
}
