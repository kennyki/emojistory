Meteor.publish 'stories', ->
  return Stories.find()