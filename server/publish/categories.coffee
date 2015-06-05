Meteor.publish 'categories', ->
  return Categories.find()