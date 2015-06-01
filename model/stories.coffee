# NOTE: assign to @ to make it available to others
@Stories = new Mongo.Collection 'stories'

### TODO: enable when social login is implemented
Stories.allow(
  insert: (userId, story) ->
    # must be logged in and create for own self
    return userId and story.owner is userId
  update: (userId, story, fields, modifier) ->
    return userId is story.owner
  remove: (userId, party) ->
    return userId is story.owner
)
###
