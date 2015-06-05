angular.module('emojistory.home', [])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'home',
    url: '/'
    templateUrl: 'client/home/home.ng.html'
    controller: 'HomeController'

.controller 'HomeController', ($scope) ->
  # not allowed to update
  $scope.categories = $scope.$meteorCollection(Categories, false).subscribe 'categories'
  $scope.stories = $scope.$meteorCollection Stories, false

  # so that it knows when something changes
  $scope.$meteorAutorun ->
    $scope.$meteorSubscribe('stories').then ->
      # NOTE: we're using publichComposite
      # so the real data of users and categories should be available now
      $scope.stories.forEach (story) ->
        # use __ to indicate display-only properties
        story.__creator = Users.findOne story.creator
        story.__category = Categories.findOne story.category