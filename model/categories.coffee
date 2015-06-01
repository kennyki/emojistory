# NOTE: assign to @ to make it available to others
@Categories = new Mongo.Collection 'categories'

# Disallow modification for now
@Categories.allow(
  insert: -> false
  update: -> false
  remove: -> false
)
