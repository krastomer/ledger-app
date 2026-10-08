abstract final class Routes {
  static const boot = '/boot';
  static const setup = '/setup';
  static const setupStart = '/setup/start';
  static const setupNew = '/setup/new';
  static const setupImport = '/setup/import';
  static const setupRules = '/setup/rules';
  static const setupPhotos = '/setup/photos';
  static const setupScan = '/setup/scan';
  static const home = '/';
  static const accounts = '/accounts';
  static const reports = '/reports';
  static const transactions = '/transactions';
  static const transaction = '/transaction/:id';
  static const inbox = '/inbox';
  static const slipReview = '/review';
  static const settings = '/settings';
  static const rules = '/settings/rules';

  static String transactionPath(String id) => '/transaction/$id';
}
