class GithubData {
  String project;
  String title;
  String description;

  GithubData({this.project = '', this.title = '', this.description = ''});
}

final fakeData = [
  GithubData(
      project: 'flutter/flutter',
      title: 'Do not ignore pubspec.lock in project templates',
      description: '#24209 opened 3 hours ago by jxltom'),
  GithubData(
      project: 'flavors/django-graphql-jwt',
      title: 'Add AuthenticationMiddleware settings to README ',
      description: '#49 opened a day ago by jxltom'),
  GithubData(
      project: 'mirumee/saleor',
      title: 'Add default test runner',
      description: '#3258 opened a day ago by jxltom'),
];
