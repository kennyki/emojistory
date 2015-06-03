# NOTE: assign to @ to make it available to others
@Stories = new Mongo.Collection 'stories'

### TODO: enable when social login is implemented
Stories.allow(
  insert: (userId, story) ->
    # must be logged in and create for own self
    return userId and story.creator is userId
  update: (userId, story, fields, modifier) ->
    return userId is story.creator
  remove: (userId, story) ->
    return userId is story.creator
)
###
