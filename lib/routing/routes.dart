abstract final class Routes {
  static const boot = '/boot';
  static const setup = '/setup';
  static const setupNew = '/setup/new';
  static const setupImport = '/setup/import';
  static const home = '/';
  static const accounts = '/accounts';
  static const reports = '/reports';
  static const transactions = '/transactions';
  static const transaction = '/transaction/:id';
  static const inbox = '/inbox';
  static const slipReview = '/review';
  static const settings = '/settings';

  static String transactionPath(String id) => '/transaction/$id';
}
