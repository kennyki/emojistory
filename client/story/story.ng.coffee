angular.module('emojistory.story', [])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'story',
    url: '/story/:id'
    templateUrl: 'client/story/story.ng.html'
    controller: 'StoryController'

.controller 'StoryController', ($scope, $stateParams) ->
  # not allowed to update
  $scope.story = $scope.$meteorObject Stories, $stateParams.id, false

  # so that it knows when something changes
  $scope.$meteorAutorun ->
    $scope.$meteorSubscribe('stories').then ->
      # update necessary stuff