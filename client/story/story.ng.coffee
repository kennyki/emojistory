angular.module('emojistory.story', [
  'emojistory.story.create'
])

.config ($stateProvider) ->
  # is where the heart is
  $stateProvider.state 'story',
    url: '/story/:id'
    templateUrl: 'client/story/story.ng.html'
    controller: 'StoryController'

.controller 'StoryController', ($scope, $stateParams, $meteor, $q, $state) ->
  # not allowed to update
  $scope.story = $scope.$meteorObject Stories, $stateParams.id, false
  $scope.isStarred = false
  $scope.canStar = false

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

  $scope.$meteorAutorun ->
    $q.all([
      $scope.$meteorSubscribe 'stories',
        _id: $stateParams.id
      $scope.$meteorSubscribe 'userData'
    ]).then ->
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