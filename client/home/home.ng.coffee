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
      # update necessary stuff