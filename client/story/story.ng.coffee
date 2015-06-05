angular.module('emojistory.story', [
  'emojistory.story.create'
  'emojistory.story.edit'
])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'story',
    url: '/story/:id'
    templateUrl: 'client/story/story.ng.html'
    controller: 'StoryController'

.controller 'StoryController', ($scope, $stateParams, $meteor,  $state, $modal) ->
  # this is for removal use
  stories = $scope.$meteorCollection Stories, false
  # not allowed to update
  $scope.story = $scope.$meteorObject Stories, $stateParams.id, false
  $scope.isStarred = false
  $scope.canStar = false
  $scope.isCreator = false

  updateStarPower = ->
    # $scope inherits from $rootScope anyway
    currentUser = $scope.currentUser
    story = $scope.story
    # can only check properly thru the raw JSON
    rawStory = story.getRawObject()

    unless rawStory._id
      # TODO: 404 page
      alert 'no such story'
      $state.go 'home'

    if story and currentUser
      $scope.isStarred = currentUser.starred and currentUser.starred.indexOf(story._id) isnt -1
      $scope.canStar = true
      $scope.isCreator = currentUser._id is story.creator

  $scope.$meteorAutorun ->
    # NOTE: need to subscribe 1 by 1 to ensure all is ready
    # $q.all doesn't seem to be able to guarantee
    $scope.$meteorSubscribe 'stories',
      _id: $stateParams.id
    .then ->
      $scope.$meteorSubscribe 'userData'
    .then ->
      story = $scope.story
      # NOTE: we're using publichComposite
      # so the real data of users and categories should be available now
      # use __ to indicate display-only properties
      story.__creator = Users.findOne story.creator
      story.__category = Categories.findOne story.category

      # process only when the story is properly loaded
      # and also when the stars change
      $scope.$watch 'story.stars', updateStarPower

  $scope.star = ->
    methodName = if $scope.isStarred then 'unstar' else 'star'

    $meteor.call(methodName, $scope.story._id).then angular.noop (reason) ->
      # TODO: display properly
      alert reason

  $scope.remove = ->
    if $scope.story.creator isnt $scope.currentUser._id
      # TODO: proper alert
      return alert 'You are not the creator of this story!'

    $modal.open
      animation: false
      templateUrl: 'client/story/remove.ng.html'
      controller: 'RemoveStoryController'
      size: 'sm'
    .result.then (confirm) ->
      return unless confirm
      stories.remove($scope.story).then ->
        $state.go 'home'
      , (error) ->
        # TODO: alert properly
        alert error

.controller 'RemoveStoryController', ($scope, $modalInstance) ->
  $scope.confirm = ->
    $modalInstance.close true

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'