# use built-in collection
@Users = Meteor.users

# disable update from the client
Users.allow(
  update: -> return false
)

# can only update thru meteor methods
Meteor.methods(
  isStarred: (storyId) ->
    currentUser = Meteor.user()
    return currentUser.starred and currentUser.starred.indexOf(storyId) isnt -1

  star: (storyId) ->
    return if Meteor.call 'isStarred', storyId
    
    # update the user first
    affected = Users.update @userId,
      $addToSet:
        starred: storyId

    return if affected is 0

    # then the story
    Stories.update
      _id: storyId
    ,
      $inc:
        stars: 1

  unstar: (storyId) ->
    return unless Meteor.call 'isStarred', storyId

    # update the user first
    affected = Users.update @userId,
      $pull:
        starred: storyId

    return if affected is 0

    # then the story
    # but only if it's greater than 0
    Stories.update
      _id: storyId
      stars:
        $gt: 0
    ,
      $inc:
        stars: -1
)