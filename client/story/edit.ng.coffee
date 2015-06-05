angular.module('emojistory.story.create', [])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'edit',
    url: '/edit/:id'
    templateUrl: 'client/story/editor.ng.html'
    controller: 'EditStoryController'

.controller 'EditStoryController', ($scope, $stateParams, $meteor, $state) ->
  storyId = $stateParams.id
  # not allowed to update
  $scope.categories = $scope.$meteorCollection(Categories, false).subscribe 'categories'
  $scope.story = $scope.$meteorObject Stories, storyId, false
  # as a reference
  $scope.oriStory = null

  $scope.cancel = backToStory = ->
    $state.go 'story',
      id: storyId

  $scope.$meteorAutorun ->
    # NOTE: need to subscribe 1 by 1 to ensure all is ready
    # $q.all doesn't seem to be able to guarantee
    $scope.$meteorSubscribe 'stories',
      _id: storyId
    .then ->
      $scope.$meteorSubscribe 'userData'
    .then ->
      if $scope.story.creator isnt $scope.currentUser._id
        # TODO: proper alert
        alert 'You are not the creator of this story!'
        return backToStory()

      $scope.oriStory = angular.extend {}, $scope.story

  $scope.canSave = ->
    oriStory = $scope.oriStory
    story = $scope.story

    # cannot save until loaded
    return false unless oriStory

    return (oriStory.title isnt story.title) or (oriStory.body isnt story.body) or (oriStory.category isnt story.category)

  $scope.save = ->
    return unless $scope.canSave()

    $scope.story.save().then(
      ->
        backToStory()
      , (error) ->
        # display properly
        alert error
    )