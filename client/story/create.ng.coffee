angular.module('emojistory.story.create', [])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'create',
    url: '/create'
    templateUrl: 'client/story/create.ng.html'
    controller: 'CreateStoryController'

.controller 'CreateStoryController', ($scope, $meteor, $q, $state) ->
  # not allowed to update
  $scope.categories = $scope.$meteorCollection(Categories, false).subscribe 'categories'
  # start binding without auto-save and subscription
  stories = $scope.$meteorCollection Stories, false

  $scope.story =
    title: ''
    body: ''
    category: null

  $scope.canSave = ->
    story = $scope.story
    return story.title and story.body and story.category

  $scope.save = ->
    return unless $scope.canSave()

    stories.save($scope.story).then(
      ->
        $state.go 'home'
      , (error) ->
        # display properly
        alert error
    )