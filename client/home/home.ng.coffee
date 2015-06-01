angular.module('emojistory.home', [])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'home',
    url: '/'
    templateUrl: 'client/home/home.ng.html'
    controller: 'HomeController'

.controller 'HomeController', ($scope, $meteor) ->
  # not allowed to update
  $scope.categories = $meteor.collection(Categories, false).subscribe 'categories'
  $scope.stories = $meteor.collection Stories, false

  # so that it knows when something changes
  $meteor.autorun $scope, ->
    $meteor.subscribe('stories').then ->
      # update necessary stuff